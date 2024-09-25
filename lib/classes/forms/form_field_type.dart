class FormFieldTypeModel {
  int formFieldTypeId;
  String? fieldType;

  FormFieldTypeModel({
    required this.formFieldTypeId,
    this.fieldType,
  });

  factory FormFieldTypeModel.fromJson(Map<String, dynamic> json) {
    return FormFieldTypeModel(
      formFieldTypeId: json['form_field_type_id'],
      fieldType: json['field_type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'form_field_type_id': formFieldTypeId,
        'field_type': fieldType,
      };
}
