import 'package:vendify_widgets_package/classes/documents/document_type.dart';

class Document {
  int documentId;
  String documentUrl;
  DocumentType documentType;
  bool? isCompleted;
  int? taskId;
  int? contactId;
  int? requestId;
  String? filename;
  DateTime? createdAt;
  DateTime? updatedAt;

  Document({
    required this.documentId,
    required this.documentUrl,
    required this.documentType,
    required this.isCompleted,
    required this.taskId,
    required this.contactId,
    required this.requestId,
    this.filename,
    this.createdAt,
    this.updatedAt,
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
        filename: json["filename"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "documentId": documentId,
        "documentUrl": documentUrl,
        "documentType": documentType,
        "isCompleted": isCompleted,
        "taskId": taskId,
        "contactId": contactId,
        "requestId": requestId,
        "filename": filename,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
