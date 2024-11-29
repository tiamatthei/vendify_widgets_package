import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

class TaskStatus {
  int? taskStatusId;
  String? taskStatus;
  bool? isCompleted;

  TaskStatus({
    this.taskStatusId,
    this.taskStatus,
    this.isCompleted,
  });

  factory TaskStatus.fromJson(Map<String, dynamic> json) => TaskStatus(
        taskStatusId: json["taskStatusId"],
        taskStatus: json["taskStatus"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "taskStatusId": taskStatusId,
        "taskStatus": taskStatus,
        "isCompleted": isCompleted,
      };

  Color get color {
    switch (taskStatus) {
      case "Pendiente":
        return TColors.warning80;
      case "Por Aprobar":
        return TColors.accent80;
      case "Aprobada":
        return TColors.success80;
      case "Rechazada":
        return TColors.error80;
      default:
        return TColors.primaryDefault;
    }
  }
}
