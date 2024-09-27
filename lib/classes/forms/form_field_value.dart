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
      formFieldValueId: json['formFieldValueId'],
      formResponseId: json['formResponseId'],
      formFieldId: json['formFieldId'],
      fieldValue: json['fieldValue'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'formFieldValueId': formFieldValueId,
        'formResponseId': formResponseId,
        'formFieldId': formFieldId,
        'fieldValue': fieldValue,
        'createdAt': createdAt?.toIso8601String(),
      };
}
