import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendify_widgets_package/classes/user.dart';
import 'package:vendify_widgets_package/constants/global.dart';
import 'package:vendify_widgets_package/utils/api/base_api.dart';
import 'package:vendify_widgets_package/utils/jwt.dart';

class AuthApi extends BaseApi {
  static const String loginEndpoint = 'auth/login';
  static const String userDataEndpoint = 'users/profile';

  static Future<bool> loadUserData() async {
    try {
      String respBody = await BaseApi.get(userDataEndpoint, withToken: true);
      Map<String, dynamic> user = jsonDecode(respBody);
      loggedUser = User.fromJson(user);
      return true;
    } catch (e) {
      log("Error trying to save user data: $e");
      return false;
    }
  }

  static Future<bool> tryAutoLogin() async {
    try {
      //if isUserActive returns true, then the user is logged in, just load the user data
      if (await TokenManager.isUserActive()) {
        return true;
      }
      log("User is not active");

      //if the user is not active, then try to login with the saved credentials
      String? token = await TokenManager.getToken();
      if (token != null) {
        Map<String, dynamic> decodedToken = TokenManager.decodeToken(token);
        log("decodedToken: $decodedToken");
        String email = decodedToken['email'];
        var prefs = await SharedPreferences.getInstance();
        String password = prefs.getString('password') ?? '';
        return await login(email, password);
      }
    } catch (e) {
      log("Error trying to auto login: $e");
      return false;
    }
    log("User is not active");
    return false;
  }

  static Future<bool> login(String email, String password) async {
    try {
      String respBody = await BaseApi.post(loginEndpoint, {
        'email': email,
        'password': password,
      }).timeout(const Duration(seconds: 10));

      String token = jsonDecode(respBody)['jwt'];
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('password', password);
      prefs.setString('email', email);
      log("login success: $token");
      await TokenManager.saveToken(token);
      return await loadUserData();
    } catch (e) {
      log("Error trying to login: $e");
      return false;
    }
  }
}
