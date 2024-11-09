import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vendify_widgets_package/constants/global.dart';
import 'package:vendify_widgets_package/utils/jwt.dart';

class BaseApi {
  static String baseUrl = apiBaseUrl;
  static String basePath = "api/";
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  static Future<String> get(String endpoint, {bool withToken = false, Map<String, String>? queryParams}) async {
    // Get the token from the storage
    if (withToken) {
      final token = await TokenManager.getToken();
      // Add the token to the headers
      headers['Authorization'] = 'Bearer $token';
    }
    var uri = environment == 'dev'
        ? Uri.http(baseUrl, '$basePath$endpoint', queryParams)
        : Uri.https(baseUrl, '$basePath$endpoint', queryParams);
    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<String> post(String endpoint, Map<String, dynamic> body,
      {bool withToken = false, Uint8List? bytes, String? fileName}) async {
    if (withToken) {
      final token = await TokenManager.getToken();
      headers['Authorization'] = 'Bearer $token';
    }
    var uri = environment == 'dev' ? Uri.http(baseUrl, '$basePath$endpoint') : Uri.https(baseUrl, '$basePath$endpoint');

    if (bytes != null) {
      var request = http.MultipartRequest('POST', uri);
      headers['Content-Type'] = 'multipart/form-data';
      request.headers.addAll(
        headers,
      );

      // transform the file into a byte array
      Uint8List byteArray = bytes;
      // Add the file, regardless of the type, remember the filename
      var multipartFile = http.MultipartFile.fromBytes('file', byteArray, filename: fileName);
      request.files.add(multipartFile);

      // Add the fields
      Map<String, String> fields = body.map((key, value) => MapEntry(key, value.toString()));
      request.fields.addAll(fields);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        log(responseBody);
        return responseBody;
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  static Future<String> patch(String endpoint, Map<String, dynamic> body, {bool withToken = false}) async {
    if (withToken) {
      final token = await TokenManager.getToken();
      headers['Authorization'] = 'Bearer $token';
      headers['Content-Type'] = 'application/json';
    }
    var uri = environment == 'dev' ? Uri.http(baseUrl, '$basePath$endpoint') : Uri.https(baseUrl, '$basePath$endpoint');
    final response = await http.patch(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<String> put(String endpoint, Map<String, dynamic> body, {bool withToken = false}) async {
    if (withToken) {
      final token = await TokenManager.getToken();
      headers['Authorization'] = 'Bearer $token';
      headers['Content-Type'] = 'application/json';
    }
    var uri = environment == 'dev' ? Uri.http(baseUrl, '$basePath$endpoint') : Uri.https(baseUrl, '$basePath$endpoint');
    http.Response response = await http.put(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<String> delete(String endpoint, Map<String, dynamic> body, {bool withToken = false}) async {
    if (withToken) {
      final token = await TokenManager.getToken();
      headers['Authorization'] = 'Bearer $token';
    }
    var uri = environment == "dev" ? Uri.http(baseUrl, '$basePath$endpoint') : Uri.https(baseUrl, '$basePath$endpoint');
    final response = await http.delete(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Uint8List> download(String endpoint, {bool withToken = false}) async {
    if (withToken) {
      final token = await TokenManager.getToken();
      headers['Authorization'] = 'Bearer $token';
    }
    var uri = environment == 'dev' ? Uri.http(baseUrl, '$basePath$endpoint') : Uri.https(baseUrl, '$basePath$endpoint');
    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
