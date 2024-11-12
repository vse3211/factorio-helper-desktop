
import 'dart:math';

String generateRandomString(int length) {
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'; // Допустимые символы
  Random random =
  Random.secure(); // Используем Random.secure() для большей безопасности
  return List.generate(
      length, (index) => characters[random.nextInt(characters.length)]).join();
}