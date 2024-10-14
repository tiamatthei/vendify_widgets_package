import 'package:vendify_widgets_package/classes/forms/form_field_type.dart';

class FormFieldModel {
  int? formFieldId;
  int? formId;
  String? label;
  bool? isRequired;
  int? fieldOrder;
  String? correspondingColumn;
  String? hintText;
  List<String>? options;
  DateTime? createdAt;
  DateTime? updatedAt;
  FormFieldTypeModel? fieldType;

  FormFieldModel({
    this.formFieldId,
    this.formId,
    this.label,
    this.isRequired,
    this.fieldOrder,
    this.correspondingColumn,
    this.hintText,
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
      hintText: json['hintText'],
      options: json['options'] != null ? List<String>.from(json['options']) : null,
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
        'isRequired': isRequired,
        'fieldOrder': fieldOrder,
        'correspondingColumn': correspondingColumn,
        'hintText': hintText,
        'options': options,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'fieldType': fieldType?.toJson(),
      };
}
