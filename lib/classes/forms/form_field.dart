import 'package:vendify_widgets_package/classes/forms/form_field_type.dart';

class FormFieldModel {
  int formFieldId;
  int? formId;
  String? label;
  bool? isRequired;
  int? fieldOrder;
  List<String>? options;
  DateTime? createdAt;
  DateTime? updatedAt;
  FormFieldTypeModel? fieldType;

  FormFieldModel({
    required this.formFieldId,
    this.formId,
    this.label,
    this.isRequired,
    this.fieldOrder,
    this.options,
    this.createdAt,
    this.updatedAt,
    this.fieldType,
  });

  factory FormFieldModel.fromJson(Map<String, dynamic> json) {
    return FormFieldModel(
      formFieldId: json['formFieldId'],
      formId: json['formId'],
      label: json['label'],
      isRequired: json['isRequired'],
      fieldOrder: json['fieldOrder'],
      options: List<String>.from(json['options']),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      fieldType: json['fieldTypeModel'] != null
          ? FormFieldTypeModel.fromJson(json['fieldTypeModel'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'formFieldId': formFieldId,
        'formId': formId,
        'label': label,
        'fieldType': fieldType,
        'isRequired': isRequired,
        'fieldOrder': fieldOrder,
        'options': options,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
