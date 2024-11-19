import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:vendify_widgets_package/classes/documents/document.dart';
import 'package:vendify_widgets_package/classes/documents/document_type.dart';
import 'package:vendify_widgets_package/utils/api/base_api.dart';

class DocumentsApi extends BaseApi {
  static const String documentsEndpoint = 'documents';

  Future<List<Document>?> getContactDocuments(int contactId) async {
    String endpoint = '$documentsEndpoint/contact/$contactId';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<Document> model = (jsonDecode(respBody) as List).map((e) => Document.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get contact documents: $e");
      return [];
    }
  }

  Future<bool> completeDocument(int documentId) async {
    try {
      String endpoint = '$documentsEndpoint/complete/$documentId';
      await BaseApi.patch(endpoint, {}, withToken: true);
      log("Document status changed successfully");
      return true;
    } catch (e) {
      log("Error trying to complete document: $e");
      return false;
    }
  }

  Future<bool> undoDocument(int documentId) async {
    try {
      String endpoint = '$documentsEndpoint/undo/$documentId';
      await BaseApi.patch(endpoint, {}, withToken: true);
      log("Document status changed successfully");
      return true;
    } catch (e) {
      log("Error trying to undo document: $e");
      return false;
    }
  }

  Future<Document> getDocumentDataById(int documentId) async {
    String endpoint = '$documentsEndpoint/data/$documentId';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      Document model = Document.fromJson(jsonDecode(respBody));
      return model;
    } catch (e) {
      log("Error trying to get document data by ID: $e");
      throw Exception('Failed to get document data by ID');
    }
  }

  Future<bool?> uploadDocument(
      int contactId, int documentTypeId, Uint8List bytes, String filename, int contactTaskId) async {
    //encode the filename to base64 or something
    String encodedFilename = base64Encode(utf8.encode(filename));
    String endpoint = '$documentsEndpoint/upload';
    Map<String, dynamic> requestBody = {
      'documentTypeId': documentTypeId,
      'contactTaskId': contactTaskId,
      'contactId': contactId,
      'filename': encodedFilename,
    };
    try {
      log("Uploading document...");
      await BaseApi.post(endpoint, requestBody, withToken: true, bytes: bytes, fileName: encodedFilename);
      return true;
    } catch (e) {
      log("Error trying to upload document: $e");
      return null;
    }
  }

  Future<bool?> uploadContactDocument(int contactId, int documentTypeId, Uint8List bytes, String filename) async {
    //encode the filename to base64 or something
    String encodedFilename = base64Encode(utf8.encode(filename));
    String endpoint = '$documentsEndpoint/upload/contact';
    Map<String, dynamic> requestBody = {
      'documentTypeId': documentTypeId,
      'contactId': contactId,
      'filename': encodedFilename,
    };
    try {
      log("Uploading document...");
      await BaseApi.post(endpoint, requestBody, withToken: true, bytes: bytes, fileName: encodedFilename);
      return true;
    } catch (e) {
      log("Error trying to upload document: $e");
      return null;
    }
  }

  Future<Uint8List?> downloadDocument(int documentId) async {
    String endpoint = '$documentsEndpoint/download/$documentId';
    try {
      log("Downloading document...");
      Uint8List file = await BaseApi.download(endpoint, withToken: true);
      return file;
    } catch (e) {
      log("Error trying to download document: $e");
      return null;
    }
  }

  Future<List<DocumentType>?> getDocumentTypes() async {
    String endpoint = '$documentsEndpoint/types';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<DocumentType> model = (jsonDecode(respBody) as List).map((e) => DocumentType.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get document types: $e");
      return null;
    }
  }

  Future<bool?> updateDocument(int documentId, int documentTypeId, Uint8List bytes, String filename) async {
    String endpoint = '$documentsEndpoint/update/$documentId';
    String encodedFilename = base64Encode(utf8.encode(filename));
    Map<String, dynamic> requestBody = {
      'documentTypeId': documentTypeId,
      'filename': encodedFilename,
    };
    try {
      log("Updating document...");
      await BaseApi.patch(endpoint, requestBody, withToken: true, bytes: bytes, fileName: encodedFilename);
      return true;
    } catch (e) {
      log("Error trying to update document: $e");
      return null;
    }
  }

  Future<int?> getActiveRejectedDocumentsCount() async {
    String endpoint = '$documentsEndpoint/rejected/count';
    try {
      log("Getting active rejected documents count...");
      String respBody = await BaseApi.get(endpoint, withToken: true);
      //parse the response body as json, then use the count key to get the count
      Map<String, dynamic> json = jsonDecode(respBody);
      return json['count'];
    } catch (e) {
      log("Error trying to get active rejected documents count: $e");
      return null;
    }
  }

  Future<List<Document>?> getActiveRejectedDocuments() async {
    String endpoint = '$documentsEndpoint/rejected';
    try {
      log("Getting active rejected documents...");
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<Document> documents = (jsonDecode(respBody) as List).map((e) => Document.fromJson(e)).toList();
      return documents;
    } catch (e) {
      log("Error trying to get active rejected documents: $e");
      return null;
    }
  }
}
