import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/tasks/task.dart';

class ContactState {
  final int? contactStateId;
  final String? state;
  final String? description;
  final int? step;
  final String? color;
  List<Task>? linkedTasks;

  ContactState({
    this.contactStateId,
    this.state,
    this.description,
    this.step,
    this.color,
    this.linkedTasks,
  });

  factory ContactState.fromJson(Map<String, dynamic> json) => ContactState(
        contactStateId: json['contactStateId'],
        state: json['state'],
        description: json['description'],
        step: json['step'],
        color: json['color'],
        linkedTasks:
            json['linkedTasks'] != null ? List<Task>.from(json['linkedTasks'].map((x) => Task.fromJson(x))) : null,
      );

  Map<String, dynamic> toJson() => {
        'contactStateId': contactStateId,
        'state': state,
        'description': description,
        'step': step,
        'color': color,
      };

  Color get colorValue {
    try {
      return Color(int.parse(color!.substring(1, 7), radix: 16) + 0xFF000000);
    } catch (e) {
      return Colors.grey;
    }
  }
}
