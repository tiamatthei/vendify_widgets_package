class DocumentType {
  int documentTypeId;
  String? documentType;

  DocumentType({required this.documentTypeId, this.documentType});

  factory DocumentType.fromJson(Map<String, dynamic> json) {
    return DocumentType(
      documentTypeId: json['documentTypeId'],
      documentType: json['documentType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'documentTypeId': documentTypeId, 'documentType': documentType};
  }
}
