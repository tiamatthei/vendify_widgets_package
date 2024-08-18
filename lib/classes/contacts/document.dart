import 'package:vendify_widgets_package/classes/contacts/document_type.dart';

class Document {
  int documentId;
  String documentUrl;
  DocumentType documentType;

  Document({
    required this.documentId,
    required this.documentUrl,
    required this.documentType,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        documentId: json["documentId"],
        documentUrl: json["documentUrl"],
        documentType: DocumentType(
          documentTypeId: json["documentTypeId"],
          documentType: json["documentType"],
        ),
      );

  Map<String, dynamic> toJson() => {
        "documentId": documentId,
        "documentUrl": documentUrl,
        "documentType": documentType,
      };
}
