import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/contacts/contact_label.dart';

class ContactState {
  final int contactStateId;
  final String state;
  final String description;
  final int step;
  final String color;
  List<ContactLabel>? linkedLabels;

  ContactState({
    required this.contactStateId,
    required this.state,
    required this.description,
    required this.step,
    required this.color,
    this.linkedLabels,
  });

  factory ContactState.fromJson(Map<String, dynamic> json) => ContactState(
        contactStateId: json['contact_state_id'] ?? 0,
        state: json['state'] ?? '',
        description: json['description'] ?? '',
        step: json['step'] ?? 0,
        color: json['color'] ?? '',
        linkedLabels: json['linkedLabels'] != null
            ? List<ContactLabel>.from(json['linkedLabels'].map((x) => ContactLabel.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'contact_state_id': contactStateId,
        'state': state,
        'description': description,
        'step': step,
        'color': color,
      };

  // Color get colorValue {
  //   return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
  // }

}
