class FormFieldTypeModel {
  int? formFieldTypeId;
  String? fieldType;

  FormFieldTypeModel({
    this.formFieldTypeId,
    this.fieldType,
  });

  factory FormFieldTypeModel.fromJson(Map<String, dynamic> json) {
    return FormFieldTypeModel(
      formFieldTypeId: json['formFieldTypeId'],
      fieldType: json['fieldType'],
    );
  }

  Map<String, dynamic> toJson() => {
        'formFieldTypeId': formFieldTypeId,
        'fieldType': fieldType,
      };
}
