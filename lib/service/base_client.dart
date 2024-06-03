import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:isocare/service/app_exceptions.dart';

class BaseClient {
  static var client = http.Client();
  static const int TIME_OUT_DURATION = 20;

  // GET
  Future<dynamic> get(String baseUrl, String api, dynamic headers) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await client
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
          'Tidak terhubung dengan jaringan internet', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', uri.toString());
    }
  }

  Future<dynamic> getwH(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await client
          .get(uri)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
          'Tidak terhubung dengan jaringan internet', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', uri.toString());
    }
  }

  // POST
  Future<dynamic> post(String baseUrl, String api, bodyObj) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await client
          .post(uri, body: bodyObj)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
          'Tidak terhubung dengan jaringan internet', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', uri.toString());
    }
  }

  // POST WITH HEADER
  Future<dynamic> postH(String baseUrl, String api, dynamic headers) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await client
          .post(uri, headers: headers)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
          'Tidak terhubung dengan jaringan internet', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', uri.toString());
    }
  }

  // POST WITH HEADER BODY
  Future<dynamic> postHB(String baseUrl, String api, headers, bodyObj) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await client
          .post(uri, body: bodyObj, headers: headers)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
          'Tidak terhubung dengan jaringan internet', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Api tidak merespon', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    final body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw BadRequestException(
            response.body, response.request!.url.toString());
      case 401:
      case 422:
        throw FetchDataException(
            body["message"], response.request!.url.toString());
      case 403:
        throw UnAuthorizedException(
            response.body, response.request!.url.toString());
      case 404:
        throw FetchDataException(
            body["message"], response.request!.url.toString());
      case 500:
        throw FetchDataException(
            body["message"], response.request!.url.toString());
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
