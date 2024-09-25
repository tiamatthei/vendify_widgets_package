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
      formFieldId: json['form_field_id'],
      formId: json['form_id'],
      label: json['label'],
      isRequired: json['is_required'],
      fieldOrder: json['field_order'],
      options: List<String>.from(json['options']),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      fieldType: json['field_type_model'] != null
          ? FormFieldTypeModel.fromJson(json['field_type_model'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'form_field_id': formFieldId,
        'form_id': formId,
        'label': label,
        'field_type': fieldType,
        'is_required': isRequired,
        'field_order': fieldOrder,
        'options': options,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
