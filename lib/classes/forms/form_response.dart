import 'package:vendify_widgets_package/classes/forms/form_field_value.dart';
import 'package:vendify_widgets_package/classes/contacts/contact.dart';

class FormResponseModel {
  int? formResponseId;
  int? formId;
  int? contactId;
  DateTime? submittedAt;
  List<FormFieldValueModel>? formFieldValues;
  ContactModel? contact;

  FormResponseModel({
    this.formResponseId,
    this.formId,
    this.contactId,
    this.submittedAt,
    this.formFieldValues,
    this.contact,
  });

  factory FormResponseModel.fromJson(Map<String, dynamic> json) {
    return FormResponseModel(
      formResponseId: json['formResponseId'],
      formId: json['formId'],
      contactId: json['contactId'],
      submittedAt: json['submittedAt'] != null ? DateTime.parse(json['submittedAt']) : null,
      formFieldValues: (json['formFieldValues'] as List<dynamic>?)
          ?.map((item) => FormFieldValueModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      contact: json['contact'] != null ? ContactModel.fromJson(json['contact']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'formResponseId': formResponseId,
        'formId': formId,
        'contactId': contactId,
        'submittedAt': submittedAt?.toIso8601String(),
        'formFieldValues': formFieldValues?.map((item) => item.toJson()).toList(),
        'contact': contact?.toJson(),
      };
}
