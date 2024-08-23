class DocumentType {
  int? documentTypeId;
  String? documentType;

  DocumentType({
    this.documentTypeId,
    this.documentType,
  });

  factory DocumentType.fromJson(Map<String, dynamic> json) => DocumentType(
        documentTypeId: json["documentTypeId"],
        documentType: json["documentType"],
      );

  Map<String, dynamic> toJson() => {
        "documentTypeId": documentTypeId,
        "documentType": documentType,
      };

}
