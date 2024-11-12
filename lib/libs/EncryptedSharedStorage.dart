import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert'; // Для работы с utf8


// Пример использования
/*
void main() async {
  // Создание экземпляра класса
  EncryptedSharedStorage eSS = EncryptedSharedStorage();

  // Генерация и сохранение ключа
  await eSS.generateAndSaveKey();

  // Шифрование и сохранение данных
  await eSS.encryptAndSaveData('username', 'user_password');

  // Загрузка и дешифрование данных
  final decryptedData = await eSS.decryptAndLoadData();

  // !!! DO NOT INVOKE print() IN PRODUCTION !!!
  print('Decrypted key: ${decryptedData['key']}');
  print('Decrypted value: ${decryptedData['value']}');
}
*/



class EncryptedSharedStorage {
  final _secureStorage = FlutterSecureStorage(); // Создаем экземпляр защищенного хранилища

  EncryptedSharedStorage();

  Future<String> generateAndSaveKey() async { // Генерация ключа шифрования AES (32 байта)
    final key = encrypt.Key.fromSecureRandom(32); // 32 байта для AES-256
    final keyString = base64UrlEncode(key.bytes); // Преобразуем в строку
    await _secureStorage.write(key: 'encryption_key', value: keyString); // Сохраняем в защищённое хранилище
    return keyString;
  }

  Future<encrypt.Key?> getEncryptionKey() async { // Получение ключа шифрования
    final keyString = await _secureStorage.read(key: 'encryption_key');

    if (keyString == null) {
      return null;
    }

    final keyBytes = base64Url.decode(keyString); // Преобразуем обратно в байты
    return encrypt.Key(keyBytes);
  }

  Future<bool> encryptAndSaveData(String key, String value) async {
    final encryptionKey = await getEncryptionKey(); // Получаем ключ шифрования
    final iv = encrypt.IV.fromSecureRandom(16); // Создаем IV для значения
    if (encryptionKey == null) return false;

    final encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey));

    // Шифруем ключ **без IV**
    final encryptedKey = encrypter.encrypt(key, iv: encrypt.IV(Uint8List.fromList([0])));

    // Шифруем значение **с использованием IV**
    final encryptedValue = compressData(encrypter.encrypt(value, iv: iv).base64);

    // Подготовим данные для сохранения (включая IV для расшифровки значения)
    final encryptedData = jsonEncode({
      'value': encryptedValue,
      'iv': iv.base64, // Сохраняем IV только для значения
    });

    // Сохраняем данные с уникальным ключом для каждого ключа (encryptedKey)
    // Сохраняем результат в защищённое хранилище или SharedPreferences
    await _secureStorage.write(key: encryptedKey.base64, value: encryptedData);
    return true;
  }

  Future<String?> decryptAndLoadData(String key) async {
    final encryptionKey = await getEncryptionKey(); // Получаем ключ шифрования
    if (encryptionKey == null) return null;
    final encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey));

    // Шифруем ключ для поиска зашифрованных данных
    final encryptedKey = encrypter.encrypt(key, iv: encrypt.IV(Uint8List.fromList([0])));

    // Загружаем зашифрованные данные из хранилища
    final encryptedDataString = await _secureStorage.read(key: encryptedKey.base64);

    if (encryptedDataString == null) {
      return null;
    }

    // Декодируем загруженные данные
    final Map<String, dynamic> encryptedData = jsonDecode(encryptedDataString);
    final iv = encrypt.IV.fromBase64(encryptedData['iv']); // Извлекаем IV
    // Дешифруем значение
    final decryptedValue = encrypter.decrypt64(
        decompressData(encryptedData['value']), iv: iv);

    return decryptedValue;
  }

  List<int> compressData(String data) {
    final input = utf8.encode(data); // Преобразуем строку в байты
    final compressed = GZipEncoder().encode(input); // Сжимаем данные
    return compressed!;
  }

  String decompressData(List<dynamic> compressedData) {
    final decompressed = GZipDecoder().decodeBytes(compressedData.cast<int>()); // Распаковываем данные
    return utf8.decode(decompressed); // Преобразуем обратно в строку
  }


}