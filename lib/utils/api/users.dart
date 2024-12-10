import 'dart:developer';
import 'dart:convert';

import 'package:vendify_widgets_package/classes/users/user.dart';
import 'package:vendify_widgets_package/utils/api/base_api.dart';

class UsersApi extends BaseApi {
  static const String usersEndpoint = 'users';
  static const String registerUserEndpoint = 'register/user';
  static const String markNoteInteractionAsSeenEndpoint = 'contact_notes_interactions';
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
      log("user body: $respBody");
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

  Future<bool> changePassword(int userId, String newPassword) async {
    String endpoint = '$usersEndpoint/change_password/$userId';
    try {
      Map<String, String> body = {
        'newPassword': newPassword,
      };
      await BaseApi.patch(endpoint, body, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to change password: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getCountContactsByState({DateTime? startDate, DateTime? endDate}) async {
    try {
      Map<String, String> queryParams = {};

      if (startDate != null) {
        queryParams['start_date'] = startDate.toIso8601String().split('T')[0];
      }

      if (endDate != null) {
        queryParams['end_date'] = endDate.toIso8601String().split('T')[0];
      }
      String respBody = await BaseApi.get("contacts/count/states", withToken: true, queryParams: queryParams);
      List<dynamic> data = jsonDecode(respBody);
      List<Map<String, dynamic>> contacts = data.map((contact) => contact as Map<String, dynamic>).toList();
      return contacts;
    } catch (e) {
      log("Error fetching contacts by state: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getUserSummary({int? userId}) async {
    try {
      String respBody = await BaseApi.get('$usersEndpoint/summary/${userId ?? ""}', withToken: true);
      Map<String, dynamic> body = jsonDecode(respBody);
      return body;
    } catch (e) {
      log("Error trying to get user summary: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUserContactNotesInteractions() async {
    try {
      String respBody = await BaseApi.get('$usersEndpoint/contact_notes_interactions', withToken: true);
      List<dynamic> data = jsonDecode(respBody);
      List<Map<String, dynamic>> notesInteractions = data.map((notesInteractions) => notesInteractions as Map<String, dynamic>).toList();
      return notesInteractions;
    } catch (e) {
      log("Error trying to get user contact notes interactions: $e");
      return [];
    }
  }

  Future<bool> markNoteInteractionAsSeen(int interactionId) async {
    try {
      String endpoint = '$usersEndpoint/usersEndpoint/$interactionId/seen';
      await BaseApi.patch(endpoint, {}, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to mark note interaction as seen: $e");
      return false;
    }
  }
}
