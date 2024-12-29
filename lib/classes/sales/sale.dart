import 'dart:convert';

import 'package:vendify_widgets_package/classes/documents/document_sale.dart';
import 'package:vendify_widgets_package/classes/sales/product.dart';
import 'package:vendify_widgets_package/classes/sales/scan.dart';

List<SaleModel> saleModelFromJson(String data) =>
    List<SaleModel>.from(json.decode(data).map((x) => SaleModel.fromJson(x)));

class SaleModel {
  SaleModel({
    this.saleId = 0,
    required this.userId,
    required this.contactId,
    required this.totalValue,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.scans,
    this.products,
    this.documents,
  });

  int saleId;
  int userId;
  int contactId;
  double totalValue;
  String? notes;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ScanModel?>? scans;
  List<SaleProduct?>? products;
  List<DocumentSale?>? documents;

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
        saleId: json["saleId"],
        userId: json["userId"],
        contactId: json["contactId"],
        totalValue: json["totalValue"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        scans: json["scans"] != null ? List<ScanModel>.from(json["scans"].map((x) => ScanModel.fromJson(x))) : null,
        products: json["products"] != null
            ? List<SaleProduct>.from(json["products"].map((x) => SaleProduct.fromJson(x)))
            : null,
        documents: json["documents"] != null
            ? List<DocumentSale>.from(json["documents"].map((x) => DocumentSale.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "saleId": saleId,
        "userId": userId,
        "contactId": contactId,
        "totalValue": totalValue,
        "notes": notes,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "scans": scans != null ? List<dynamic>.from(scans!.map((x) => x!.toJson())) : null,
        "products": products != null ? List<dynamic>.from(products!.map((x) => x!.toJson())) : null,
        "documents": documents != null ? List<dynamic>.from(documents!.map((x) => x!.toJson())) : null,
      };

  @override
  String toString() {
    return 'SaleModel{saleId: $saleId, userId: $userId, contactId: $contactId, totalValue: $totalValue, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, scans: $scans, products: $products, documents: $documents}';
  }

  bool hasAllArguments() {
    return userId != 0 &&
        contactId != 0 &&
        totalValue != 0.0 &&
        notes != null &&
        (scans != null || products != null || documents != null);
  }
}
