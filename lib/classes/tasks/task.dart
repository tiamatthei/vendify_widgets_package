import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/tasks/task_type.dart';

class Task {
  final int taskId;
  final String? title;
  final String? description;
  final bool? completed;
  final int? contactId;
  final int? contactStateId;
  final TaskType? taskType;
  final DateTime? completedAt;
  final bool? isAdmin;

  Task({
    required this.taskId,
    this.title,
    this.description,
    this.completed,
    this.contactId,
    this.contactStateId,
    this.taskType,
    this.completedAt,
    this.isAdmin,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskId: json["taskId"],
        title: json["title"],
        description: json["description"],
        completed: json["completed"],
        contactId: json["contactId"],
        contactStateId: json["contactStateId"],
        taskType: TaskType.fromJson(
          {
            "taskTypeId": json["taskTypeId"],
            "type": json["type"],
          },
        ),
        completedAt: json["completedAt"] != null ? DateTime.parse(json["completedAt"]) : null,
        isAdmin: json["isAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "taskId": taskId,
        "title": title,
        "description": description,
        "completed": completed,
        "contactId": contactId,
        "contactStateId": contactStateId,
        "taskType": taskType?.toJson(),
        "completedAt": completedAt?.toIso8601String(),
        "isAdmin": isAdmin,
      };

  IconData get icon {
    switch (taskType?.type) {
      case "UPLOAD":
        return Icons.upload_file;
      case "CHECKBOX":
        return Icons.check_box;
      default:
        return Icons.error;
    }
  }
}
