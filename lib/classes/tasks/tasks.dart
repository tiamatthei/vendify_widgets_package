import 'package:vendify_widgets_package/classes/tasks/task_type.dart';

class Task {
  final int taskId;
  final String? title;
  final String? description;
  final bool? completed;
  final int? contactId;
  final int? requestId;
  final TaskType? taskType;

  Task({
    required this.taskId,
    this.title,
    this.description,
    this.completed,
    this.contactId,
    this.requestId,
    this.taskType,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskId: json["taskId"],
        title: json["title"],
        description: json["description"],
        completed: json["completed"],
        contactId: json["contactId"],
        requestId: json["requestId"],
        taskType: TaskType.fromJson(
          {
            "taskTypeId": json["taskTypeId"],
            "type": json["type"],
          },
        ),
      );

  Map<String, dynamic> toJson() => {
        "taskId": taskId,
        "title": title,
        "description": description,
        "completed": completed,
        "contactId": contactId,
        "requestId": requestId,
        "taskType": taskType?.toJson(),
      };
  
}
