import 'dart:convert';
import 'dart:developer';

import 'package:vendify_widgets_package/classes/tasks/extra_task.dart';
import 'package:vendify_widgets_package/classes/tasks/task.dart';
import 'package:vendify_widgets_package/classes/tasks/task_type.dart';
import 'package:vendify_widgets_package/utils/api/base_api.dart';

class TaskOrders {
  static const String titleAsc = 'titleAsc';
  static const String titleDesc = 'titleDesc';
  static const String descriptionAsc = 'descriptionAsc';
  static const String descriptionDesc = 'descriptionDesc';
  static const String completedAsc = 'completedAsc';
  static const String completedDesc = 'completedDesc';
  static const String contactIdAsc = 'contactIdAsc';
  static const String contactIdDesc = 'contactIdDesc';
  static const String requestIdAsc = 'requestIdAsc';
  static const String requestIdDesc = 'requestIdDesc';
  static const String taskTypeIdAsc = 'taskTypeIdAsc';
  static const String taskTypeIdDesc = 'taskTypeIdDesc';
}

enum TaskStatus { pending, completed, rejected }

class TasksApi extends BaseApi {
  static const String tasksEndpoint = 'tasks';

  Future<List<Task>?> getUserTasks({
    int page = 1,
    String order = TaskOrders.titleAsc,
    String? startDate,
    String? endDate,
    String? search,
    TaskStatus? taskStatus,
    bool? isAdmin,
  }) async {
    String endpoint = '$tasksEndpoint/user';
    Map<String, String> queryParameters = {
      'page': page.toString(),
      'order': order.toString(),
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (search != null) 'search': search,
      if (isAdmin != null) 'isAdmin': isAdmin.toString(),
    };

    switch (taskStatus) {
      case TaskStatus.pending:
        queryParameters['isCompleted'] = "null";
        break;
      case TaskStatus.completed:
        queryParameters['isCompleted'] = 'true';
        break;
      case TaskStatus.rejected:
        queryParameters['isCompleted'] = 'false';
        break;
      default:
        break;
    }

    try {
      String respBody = await BaseApi.get(endpoint, withToken: true, queryParams: queryParameters);
      List<Task> model = (jsonDecode(respBody) as List).map((e) => Task.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get user tasks: $e");
      return [];
    }
  }

  Future<List<Task>?> getContactTasks({
    int? contactId,
    int page = 1,
    String order = TaskOrders.titleAsc,
    String? startDate,
    String? endDate,
    String? search,
  }) async {
    String endpoint = '$tasksEndpoint/contact/$contactId';
    Map<String, String> queryParameters = {
      'page': page.toString(),
      'order': order.toString(),
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (search != null) 'search': search,
    };
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true, queryParams: queryParameters);
      List<Task> model = (jsonDecode(respBody) as List).map((e) => Task.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get contact tasks: $e");
      return [];
    }
  }

  Future<List<Task>?> getStateTasks(int stateId) async {
    String endpoint = '$tasksEndpoint/state/$stateId';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<Task> model = (jsonDecode(respBody) as List).map((e) => Task.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get state tasks: $e");
      return [];
    }
  }

  Future<List<Task>?> getContactStateTask(int contactId, int stateId) async {
    String endpoint = '$tasksEndpoint/contact/$contactId/state/$stateId';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<Task> model = (jsonDecode(respBody) as List).map((e) => Task.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get contact state tasks: $e");
      return [];
    }
  }

  Future<Task> createTask(Task task) async {
    String endpoint = tasksEndpoint;
    try {
      log("Creating task...");
      String respBody = await BaseApi.post(endpoint, task.toJson(), withToken: true);
      Task model = Task.fromJson(jsonDecode(respBody));
      return model;
    } catch (e) {
      log("Error trying to create task: $e");
      throw Exception('Failed to create task');
    }
  }

  Future<Task> updateTask(int taskId, Task task) async {
    String endpoint = '$tasksEndpoint/$taskId';
    try {
      log("Updating task...");
      String respBody = await BaseApi.patch(endpoint, task.toJson(), withToken: true);
      Task model = Task.fromJson(jsonDecode(respBody));
      return model;
    } catch (e) {
      log("Error trying to update task: $e");
      throw Exception('Failed to update task');
    }
  }

  Future<bool> markAsCompleted(
    int taskId,
    int contactId, {
    String? data,
    double? userLatitude,
    double? userLongitude,
  }) async {
    String endpoint = '$tasksEndpoint/complete';
    try {
      Map<String, dynamic> body = {
        'taskId': taskId,
        'contactId': contactId,
        'data': data,
        'user_latitude': userLatitude,
        'user_longitude': userLongitude,
      };
      log("Marking task as completed...");
      await BaseApi.patch(endpoint, body, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to mark task as completed: $e");
      return false;
    }
  }

  Future<bool> undoCompleted(int taskId, int contactId) async {
    String endpoint = '$tasksEndpoint/undo';
    try {
      log("Undoing task completion...");
      await BaseApi.patch(endpoint, {'taskId': taskId, 'contactId': contactId}, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to undo task completion: $e");
      return false;
    }
  }

  Future<void> deleteTask(int taskId, int contactId) async {
    String endpoint = '$tasksEndpoint/$taskId';
    try {
      log("Deleting task...");
      await BaseApi.delete(endpoint, {}, withToken: true);
    } catch (e) {
      log("Error trying to delete task: $e");
      throw Exception('Failed to delete task');
    }
  }

  Future<List<TaskType>?> getTaskTypes() async {
    String endpoint = '$tasksEndpoint/types';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<TaskType> model = (jsonDecode(respBody) as List).map((e) => TaskType.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get task types: $e");
      return [];
    }
  }

  Future<bool> deleteContactTask(int taskId, int contactId) async {
    String endpoint = '$tasksEndpoint/contact/$contactId/task/$taskId';
    try {
      log("Deleting contact task...");
      await BaseApi.delete(endpoint, {}, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to delete contact task: $e");
      throw Exception('Failed to delete contact task');
    }
  }

  Future<ExtraTask> createContactExtraTask(ExtraTask task, int contactId) async {
    String endpoint = '$tasksEndpoint/contact/$contactId/extra';
    try {
      log("Creating extra task...");
      String respBody = await BaseApi.post(endpoint, task.toJson(), withToken: true);
      ExtraTask model = ExtraTask.fromJson(jsonDecode(respBody));
      return model;
    } catch (e) {
      log("Error trying to create extra task: $e");
      throw Exception('Failed to create extra task');
    }
  }

  Future<List<ExtraTask>?> getContactExtraTasks(int contactId) async {
    String endpoint = '$tasksEndpoint/contact/$contactId/extra';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<ExtraTask> model = (jsonDecode(respBody) as List).map((e) => ExtraTask.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get extra tasks: $e");
      return [];
    }
  }

  Future<List<ExtraTask>?> getContactExtraTasksByState(int contactId, int stateId) async {
    String endpoint = '$tasksEndpoint/contact/$contactId/state/$stateId/extra';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<ExtraTask> model = (jsonDecode(respBody) as List).map((e) => ExtraTask.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get extra tasks by state: $e");
      return [];
    }
  }

  Future<bool> completeExtraTask(
    int extraTaskId,
    int contactId, {
    String? data,
    double? userLatitude,
    double? userLongitude,
  }) async {
    String endpoint = '$tasksEndpoint/extra/complete';
    try {
      Map<String, dynamic> body = {
        'extraTaskId': extraTaskId,
        'contactId': contactId,
        'data': data,
        'user_latitude': userLatitude,
        'user_longitude': userLongitude,
      };
      log("Marking extra task as completed...");
      await BaseApi.patch(endpoint, body, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to mark extra task as completed: $e");
      return false;
    }
  }

  Future<bool> undoExtraTask(int extraTaskId, int contactId) async {
    String endpoint = '$tasksEndpoint/extra/undo';
    try {
      log("Undoing extra task completion...");
      await BaseApi.patch(endpoint, {'extraTaskId': extraTaskId, 'contactId': contactId}, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to undo extra task completion: $e");
      return false;
    }
  }
  
  Future<void> deleteExtraTask(int extraTaskId) async {
    String endpoint = '$tasksEndpoint/extra/$extraTaskId';
    try {
      log("Deleting extra task...");
      await BaseApi.delete(endpoint, {}, withToken: true);
    } catch (e) {
      log("Error trying to delete extra task: $e");
      throw Exception('Failed to delete extra task');
    }
  }

}
