import 'dart:developer';
import 'dart:convert';

import 'package:vendify_widgets_package/classes/users/user.dart';
import 'package:vendify_widgets_package/utils/api/base_api.dart';

class UsersApi extends BaseApi {
  static const String usersEndpoint = 'users';
  static const String registerUserEndpoint = 'register/user';
  Future<List<User>> getUsers(
      {int page = 1, String? orderFilter, List<Map<String, String>> userFilters = const []}) async {
    String endpoint = usersEndpoint;
    Map<String, String> queryParams = {
      'page': page.toString(),
    };
    if (orderFilter != null) {
      queryParams['order'] = orderFilter;
    }

    if (userFilters.isNotEmpty) {
      for (Map<String, String> filter in userFilters) {
        queryParams.addAll(filter);
      }
    }

    try {
      String respBody = await BaseApi.get(endpoint, withToken: true, queryParams: queryParams);
      List<dynamic> body = jsonDecode(respBody);
      List<User> users = body.map((user) => User.fromJson(user)).toList();
      log("users loaded: $users");
      return users;
    } catch (e) {
      log("Error trying to get users: $e");
      return [];
    }
  }

  Future<User?> getUser(int userId) async {
    try {
      String respBody = await BaseApi.get('$usersEndpoint/user/$userId', withToken: true);
      log( "user body: $respBody");
      Map<String, dynamic> body = jsonDecode(respBody);
      User? user = User.fromJson(body);
      return user;
    } catch (e) {
      log("Error trying to get user: $e");
      return null;
    }
  }

  Future<User?> createUser(User user) async {
    try {
      String respBody = await BaseApi.post(registerUserEndpoint, user.toJson(), withToken: true);
      Map<String, dynamic> body = jsonDecode(respBody);
      User? newUser = User.fromJson(body);
      return newUser;
    } catch (e) {
      log("Error trying to create user: $e");
      return null;
    }
  }

  Future<List<User>?>? getLeaderboard() async {
    try {
      String respBody = await BaseApi.get('$usersEndpoint/leaderboard', withToken: true);
      List<dynamic> body = jsonDecode(respBody);
      List<User> users = body.map((user) => User.fromJson(user)).toList();
      return users;
    } catch (e) {
      log("Error trying to get leaderboard: $e");
      return null;
    }
  }
}
