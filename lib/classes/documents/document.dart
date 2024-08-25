import 'package:vendify_widgets_package/classes/documents/document_type.dart';

class Document {
  int documentId;
  String documentUrl;
  DocumentType documentType;
  bool isCompleted;
  int taskId;
  int contactId;
  int requestId;

  Document({
    required this.documentId,
    required this.documentUrl,
    required this.documentType,
    required this.isCompleted,
    required this.taskId,
    required this.contactId,
    required this.requestId,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        documentId: json["documentId"],
        documentUrl: json["documentUrl"],
        documentType: DocumentType(
          documentTypeId: json["documentTypeId"],
          documentType: json["documentType"],
        ),
        isCompleted: json["isCompleted"],
        taskId: json["taskId"],
        contactId: json["contactId"],
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "documentId": documentId,
        "documentUrl": documentUrl,
        "documentType": documentType,
        "isCompleted": isCompleted,
        "taskId": taskId,
        "contactId": contactId,
        "requestId": requestId,
      };
}
