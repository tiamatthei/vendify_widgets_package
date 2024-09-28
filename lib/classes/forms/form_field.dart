import 'package:vendify_widgets_package/classes/forms/form_field_type.dart';

class FormFieldModel {
  int formFieldId;
  int? formId;
  String? label;
  bool? isRequired;
  int? fieldOrder;
  String? correspondingColumn;
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
    this.correspondingColumn,
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
      correspondingColumn: json['correspondingColumn'],
      options: List<String>.from(json['options']),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      fieldType: FormFieldTypeModel.fromJson({
        'formFieldTypeId': json['formFieldTypeId'],
        'fieldType': json['fieldType'],
      }),
    );
  }

  Map<String, dynamic> toJson() => {
        'formFieldId': formFieldId,
        'formId': formId,
        'label': label,
        'fieldType': fieldType?.toJson(),
        'isRequired': isRequired,
        'fieldOrder': fieldOrder,
        'correspondingColumn': correspondingColumn,
        'options': options,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
