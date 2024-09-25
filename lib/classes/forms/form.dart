import 'package:vendify_widgets_package/classes/forms/form_field.dart';

class FormModel {
  int formId;
  String? title;
  String? description;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<FormFieldModel>? formFields;

  FormModel({
    required this.formId,
    this.title,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.formFields,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      formId: json['form_id'],
      title: json['title'],
      description: json['description'],
      createdBy: json['created_by'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      formFields: json['form_fields'] != null
          ? List<FormFieldModel>.from(json['form_fields'].map((x) => FormFieldModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'form_id': formId,
        'title': title,
        'description': description,
        'created_by': createdBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'form_fields': formFields?.map((x) => x.toJson()).toList(),
      };
}
