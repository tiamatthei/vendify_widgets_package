import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

class TaskType {
  int taskTypeId;
  String? type;

  TaskType({
    required this.taskTypeId,
    this.type,
  });

  factory TaskType.fromJson(Map<String, dynamic> json) => TaskType(
        taskTypeId: json["taskTypeId"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "taskTypeId": taskTypeId,
        "type": type,
      };

  Color get color {
    switch (type) {
      case "UPLOAD":
        return TColors.accent80;
      case "CHECKBOX":
        return TColors.success80;
      default:
        return TColors.primaryDefault;
    }
  }
}
