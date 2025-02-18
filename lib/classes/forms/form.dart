import 'package:vendify_widgets_package/classes/forms/form_field.dart';

class FormModel {
  int? formId;
  String? title;
  String? description;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<FormFieldModel>? formFields;

  FormModel({
    this.formId,
    this.title,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.formFields,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      formId: json['formId'],
      title: json['title'],
      description: json['description'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      formFields: json['formFields'] != null
          ? List<FormFieldModel>.from(json['formFields'].map((x) => FormFieldModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'formId': formId,
        'title': title,
        'description': description,
        'createdBy': createdBy,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'formFields': formFields?.map((x) => x.toJson()).toList(),
      };
}

class FormFieldValueStat {
  final String fieldValue;
  final int count;
  final double percentage;
  final String fieldLabel;

  FormFieldValueStat({
    required this.fieldValue,
    required this.count,
    required this.percentage,
    required this.fieldLabel,
  });

  factory FormFieldValueStat.fromJson(Map<String, dynamic> json) {
    return FormFieldValueStat(
      fieldValue: json['fieldValue'],
      count: json['count'],
      percentage: json['percentage']?.toDouble() ?? 0.0,
      fieldLabel: json['fieldLabel'],
    );
  }
}