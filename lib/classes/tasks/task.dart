import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/tasks/task_type.dart';

class Task {
  int contactTaskId;
  int? taskId;
  String? title;
  String? description;
  bool? completed;
  int? contactId;
  int? contactStateId;
  TaskType? taskType;
  DateTime? completedAt;
  bool? isAdmin;
  String? contactName;
  String? businessName;
  String? data;
  String? notes;

  Task({
    required this.contactTaskId,
    this.taskId,
    this.title,
    this.description,
    this.completed,
    this.contactId,
    this.contactStateId,
    this.taskType,
    this.completedAt,
    this.isAdmin,
    this.contactName,
    this.businessName,
    this.data,
    this.notes,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        contactTaskId: json["contactTaskId"],
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
        contactName: json["contactName"],
        businessName: json["businessName"],
        data: json["data"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "contactTaskId": contactTaskId,
        "taskId": taskId,
        "title": title,
        "description": description,
        "completed": completed,
        "contactId": contactId,
        "contactStateId": contactStateId,
        "taskType": taskType?.toJson(),
        "completedAt": completedAt?.toIso8601String(),
        "isAdmin": isAdmin,
        "contactName": contactName,
        "businessName": businessName,
        "data": data,
        "notes": notes,
      };

  IconData get icon {
    switch (taskType?.type) {
      case "UPLOAD":
        return Icons.upload_file;
      case "CHECKBOX":
        return Icons.check_box;
      case "SCAN":
        return Icons.qr_code;
      default:
        return Icons.error;
    }
  }
}
