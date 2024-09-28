import 'package:vendify_widgets_package/classes/forms/form_field.dart';

class FormFieldValueModel {
  int? formFieldValueId;
  int? formResponseId;
  FormFieldModel? formField;
  String? fieldValue;
  DateTime? createdAt;

  FormFieldValueModel({
    this.formFieldValueId,
    this.formResponseId,
    this.formField,
    this.fieldValue,
    this.createdAt,
  });

  factory FormFieldValueModel.fromJson(Map<String, dynamic> json) {
    return FormFieldValueModel(
      formFieldValueId: json['formFieldValueId'],
      formResponseId: json['formResponseId'],
      formField: FormFieldModel.fromJson({
        'formFieldId': json['formFieldId'],
        'formId': json['formId'],
        'label': json['label'],
        'fieldType': json['fieldType'],
        'isRequired': json['isRequired'],
        'fieldOrder': json['fieldOrder'],
        'correspondingColumn': json['correspondingColumn'],
        'options': json['options'],
        'createdAt': json['createdAt'],
        'updatedAt': json['updatedAt'],
      }),
      fieldValue: json['fieldValue'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'formFieldValueId': formFieldValueId,
        'formResponseId': formResponseId,
        'fieldValue': fieldValue,
        'createdAt': createdAt?.toIso8601String(),
      };
}
