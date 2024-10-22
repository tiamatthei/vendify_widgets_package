import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/tasks/task.dart';

class ContactState {
  int? contactStateId;
  String? state;
  String? description;
  int? step;
  String? color;
  List<Task>? linkedTasks;
  bool? userAdvance;

  ContactState({
    this.contactStateId,
    this.state,
    this.description,
    this.step,
    this.color,
    this.linkedTasks,
    this.userAdvance,
  });

  factory ContactState.fromJson(Map<String, dynamic> json) => ContactState(
        contactStateId: json['contactStateId'],
        state: json['state'],
        description: json['description'],
        step: json['step'],
        color: json['color'],
        linkedTasks:
            json['linkedTasks'] != null ? List<Task>.from(json['linkedTasks'].map((x) => Task.fromJson(x))) : null,
        userAdvance: json['userAdvance'],
      );

  Map<String, dynamic> toJson() => {
        'contactStateId': contactStateId,
        'state': state,
        'description': description,
        'step': step,
        'color': color,
        'linkedTasks': linkedTasks != null ? List<dynamic>.from(linkedTasks!.map((x) => x.toJson())) : null,
        'userAdvance': userAdvance,
      };

  Color get colorValue {
    try {
      return Color(int.parse(color!.substring(1, 7), radix: 16) + 0xFF000000);
    } catch (e) {
      return Colors.grey;
    }
  }
}
