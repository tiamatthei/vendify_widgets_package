import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/tasks/task_type.dart';

class Task {
  final int taskId;
  final String? title;
  final String? description;
  final bool? completed;
  final int? contactId;
  final TaskType? taskType;
  final DateTime? completedAt; // Added completedAt property

  Task({
    required this.taskId,
    this.title,
    this.description,
    this.completed,
    this.contactId,
    this.taskType,
    this.completedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskId: json["taskId"],
        title: json["title"],
        description: json["description"],
        completed: json["completed"],
        contactId: json["contactId"],
        taskType: TaskType.fromJson(
          {
            "taskTypeId": json["taskTypeId"],
            "type": json["type"],
          },
        ),
        completedAt: json["completedAt"] != null ? DateTime.parse(json["completedAt"]) : null, // Added completedAt parsing
      );

  Map<String, dynamic> toJson() => {
        "taskId": taskId,
        "title": title,
        "description": description,
        "completed": completed,
        "contactId": contactId,
        "taskType": taskType?.toJson(),
        "completedAt": completedAt?.toIso8601String(), // Added completedAt serialization
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
