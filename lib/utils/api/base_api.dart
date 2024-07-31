/** TODO USE THIS, FIGURE OUT HOW TO USE IT MAINTAINING STATIC METHODS AND NON STATIC VARIABLES 
 * 
import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseApi {
  String baseUrl;

  BaseApi({required this.baseUrl});

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  static Future<String> get(String endpoint, {bool withToken = false, Map<String, dynamic>? queryParams}) async {
    // Get the token from the storage
    if (withToken) {
      final token = await TokenManager.getToken();
      // Add the token to the headers
      headers['Authorization'] = 'Bearer $token';
    }
    var uri =
        environment == "dev" ? Uri.http(baseUrl, endpoint, queryParams) : Uri.https(baseUrl, endpoint, queryParams);
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

  static Future<String> post(String endpoint, Map<String, dynamic> body, {bool withToken = false}) async {
    if (withToken) {
      final token = await TokenManager.getToken();
      headers['Authorization'] = 'Bearer $token';
    }
    var uri = environment == "dev" ? Uri.http(baseUrl, endpoint) : Uri.https(baseUrl, endpoint);
    final response = await http.post(
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

  static Future<String> patch(String endpoint, Map<String, dynamic> body, {bool withToken = false}) async {
    if (withToken) {
      final token = await TokenManager.getToken();
      headers['Authorization'] = 'Bearer $token';
    }
    var uri = environment == "dev" ? Uri.http(baseUrl, endpoint) : Uri.https(baseUrl, endpoint);
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

  static Future<String> delete(String endpoint, Map<String, dynamic> body, {bool withToken = false}) async {
    if (withToken) {
      final token = await TokenManager.getToken();
      headers['Authorization'] = 'Bearer $token';
    }
    var uri = environment == "dev" ? Uri.http(baseUrl, endpoint) : Uri.https(baseUrl, endpoint);
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
}

 */