import 'package:vendify_widgets_package/classes/forms/form_field_value.dart';

class FormResponseModel {
  int formResponseId;
  int? formId;
  int? contactId;
  DateTime? submittedAt;
  List<FormFieldValueModel>? formFieldValues;

  FormResponseModel({
    required this.formResponseId,
    this.formId,
    this.contactId,
    this.submittedAt,
    this.formFieldValues,
  });

  factory FormResponseModel.fromJson(Map<String, dynamic> json) {
    return FormResponseModel(
      formResponseId: json['form_response_id'],
      formId: json['form_id'],
      contactId: json['contact_id'],
      submittedAt: json['submitted_at'] != null ? DateTime.parse(json['submitted_at']) : null,
      formFieldValues: (json['form_field_values'] as List<dynamic>?)
          ?.map((item) => FormFieldValueModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'form_response_id': formResponseId,
        'form_id': formId,
        'contact_id': contactId,
        'submitted_at': submittedAt?.toIso8601String(),
        'form_field_values': formFieldValues?.map((item) => item.toJson()).toList(),
      };
}
