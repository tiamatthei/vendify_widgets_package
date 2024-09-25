class FormFieldValueModel {
 int formFieldValueId;
 int? formResponseId;
 int? formFieldId;
 String? fieldValue;
 DateTime? createdAt;

  FormFieldValueModel({
    required this.formFieldValueId,
    this.formResponseId,
    this.formFieldId,
    this.fieldValue,
    this.createdAt,
  });

  factory FormFieldValueModel.fromJson(Map<String, dynamic> json) {
    return FormFieldValueModel(
      formFieldValueId: json['form_field_value_id'],
      formResponseId: json['form_response_id'],
      formFieldId: json['form_field_id'],
      fieldValue: json['field_value'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'form_field_value_id': formFieldValueId,
        'form_response_id': formResponseId,
        'form_field_id': formFieldId,
        'field_value': fieldValue,
        'created_at': createdAt?.toIso8601String(),
      };
}
