import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../helpers/url.dart';
import '../models/user_model.dart';

Future<UserModel> auth(username, password) async {
  final response = await http.post(
    Uri.parse(postAuthUrl),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    encoding: Encoding.getByName('utf-8'),
    body: {
      'username': username,
      'password': sha1.convert(utf8.encode(password)).toString(),
    },
  );

  // if (response.statusCode == 200) {
  return UserModel.fromJson(json.decode(response.body));
  // } else {
  // throw Exception('Failed to login.');
  // }
}
