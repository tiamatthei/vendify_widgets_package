import 'package:vendify_widgets_package/classes/tasks/task.dart';

class ContactState {
  final int contactStateId;
  final String state;
  final String description;
  final int step;
  final String color;
  List<Task>? linkedTasks;

  ContactState({
    required this.contactStateId,
    required this.state,
    required this.description,
    required this.step,
    required this.color,
    this.linkedTasks,
  });

  factory ContactState.fromJson(Map<String, dynamic> json) => ContactState(
        contactStateId: json['contact_state_id'] ?? 0,
        state: json['state'] ?? '',
        description: json['description'] ?? '',
        step: json['step'] ?? 0,
        color: json['color'] ?? '',
        linkedTasks: json['linkedTasks'] != null
            ? List<Task>.from(json['linkedTasks'].map((x) => Task.fromJson(x)))
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
