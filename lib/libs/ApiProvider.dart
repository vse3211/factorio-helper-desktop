import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:encrypt/encrypt.dart';

class ApiProvider {
  final String uri; // Example: https://domain.com/myapi or https://domain.com
  final String webClient; // TODO add webclient support
  ApiProvider(this.uri, this.webClient);

  String checkGetDataRequest(String page, Map<String, String> data) =>
      '$uri/$page?${data.entries.map((entry) {
        return '${entry.key}=${entry.value}';
      }).join('&')}';

  // Get request with parameters
  Future<http.Response> getWithData(
          String page, Map<String, String> data) async =>
      await http.get(Uri.parse('$uri/$page?${data.entries.map((entry) {
        return '${entry.key}=${entry.value}';
      }).join('&')}'));

  // Get request without parameters
  Future<http.Response> getWithoutData(String page) async =>
      await http.get(Uri.parse('$uri/$page'));

  Future<http.Response> postWithData (String page, String data, String contentType) async => //application/json
      await http.post(
        Uri.parse('$uri/$page'),
        headers: {'Content-Type': contentType},
        body: data,
      );

  Future<String?> registerTerminal(String encryptionKey) async {
    final response =  await postWithData('register', jsonEncode(<String, String>{
      'encryptionKey': encryptionKey,
    }), 'application/json');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['id'];
    } else {
      return null;
    }
  }

  Future<bool> authorizeUser(String id, String token) async {
    final response = await postWithData('login', jsonEncode(<String, String>{
      'id': id,
      'token': token
    }), 'application/json');

    return response.statusCode == 200 && response.body == 'OK';
  }

  String encryptData(String data, String encryptionKey) {
    final key = Key.fromUtf8(encryptionKey);
    final iv = IV.fromLength(DateTime.now().toUtc().day * DateTime.now().toUtc().hour);
    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }
}
