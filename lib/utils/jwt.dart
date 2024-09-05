import 'dart:developer';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendify_widgets_package/utils/api/auth.dart';

class TokenManager {
  static const _tokenKey = 'token';
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static Future<void> saveToken(String token) async {
    (await prefs).setString(_tokenKey, token);
    // Get from storage
    final tokenFromStorage = (await prefs).getString(_tokenKey);
    log(tokenFromStorage.toString());
  }

  static Future<String?> getToken() async {
    final tok = (await prefs).getString(_tokenKey);
    return tok;
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Map<String, dynamic> decodeToken(String token) {
    return JwtDecoder.decode(token);
  }

  static Future<bool> isUserActive() async {
    try {
      final token = await getToken();
      if (token != null) {
        if (JwtDecoder.isExpired(token)) {
          return false;
        }
        return await AuthApi.loadUserData();
      }
    } catch (e) {
      log("Error trying to check if user is active: $e");
    }
    return false;
  }

  static getPayload() async {
    final token = await getToken();
    if (token != null) {
      return decodeToken(token);
    }
    return null;
  }
}
