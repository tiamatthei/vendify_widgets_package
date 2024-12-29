import 'dart:convert';
import 'dart:developer';

import 'package:vendify_widgets_package/classes/documents/document_sale.dart';
import 'package:vendify_widgets_package/classes/sales/product.dart';
import 'package:vendify_widgets_package/classes/sales/sale.dart';
import 'package:vendify_widgets_package/classes/sales/scan.dart';
import 'package:vendify_widgets_package/utils/api/base_api.dart';

class SalesApi extends BaseApi {
  static const String salesEndpoint = 'sales';

  Future<List<SaleModel?>> getSales(int? userId, int? contactId, DateTime? startDate, DateTime? endDate) async {
    Map<String, String> queryParams = {};
    if (userId != null) queryParams['userId'] = userId.toString();
    if (contactId != null) queryParams['contactId'] = contactId.toString();
    if (startDate != null) queryParams['startDate'] = startDate.toIso8601String().split('T')[0];
    if (endDate != null) queryParams['endDate'] = endDate.toIso8601String().split('T')[0];

    try {
      String response = await BaseApi.get("$salesEndpoint/", withToken: true, queryParams: queryParams);
      List<SaleModel> sales = saleModelFromJson(response);
      return sales;
    } catch (e) {
      log("Error getting sales: $e");
      return [];
    }
  }

  Future<SaleModel?> getSale(int saleId, int? userId, int? contactId, DateTime? startDate, DateTime? endDate) async {
    Map<String, String> queryParams = {};
    if (userId != null) queryParams['userId'] = userId.toString();
    if (contactId != null) queryParams['contactId'] = contactId.toString();
    if (startDate != null) queryParams['startDate'] = startDate.toIso8601String().split('T')[0];
    if (endDate != null) queryParams['endDate'] = endDate.toIso8601String().split('T')[0];

    try {
      String response = await BaseApi.get("$salesEndpoint/$saleId", withToken: true, queryParams: queryParams);
      Map<String, dynamic> body = jsonDecode(response);
      SaleModel sale = SaleModel.fromJson(body);
      return sale;
    } catch (e) {
      log("Error getting sale: $e");
      return null;
    }
  }

  Future<SaleModel?> createSale(SaleModel sale) async {
    try {
      String response = await BaseApi.post("$salesEndpoint/", sale.toJson(), withToken: true);
      Map<String, dynamic> body = jsonDecode(response);
      SaleModel newSale = SaleModel.fromJson(body);
      return newSale;
    } catch (e) {
      log("Error creating sale: $e");
      return null;
    }
  }

  Future<SaleModel?> updateSale(SaleModel sale) async {
    try {
      String response = await BaseApi.patch("$salesEndpoint/${sale.saleId}", sale.toJson(), withToken: true);
      Map<String, dynamic> body = jsonDecode(response);
      SaleModel updatedSale = SaleModel.fromJson(body);
      return updatedSale;
    } catch (e) {
      log("Error updating sale: $e");
      return null;
    }
  }

  Future<bool> deleteSale(int saleId) async {
    try {
      await BaseApi.delete("$salesEndpoint/$saleId", {}, withToken: true);
      return true;
    } catch (e) {
      log("Error deleting sale: $e");
      return false;
    }
  }

  Future<SaleProduct?> createSaleProduct(SaleProduct saleProduct, int saleId) async {
    try {
      String response = await BaseApi.post("$salesEndpoint/$saleId/products", saleProduct.toJson(), withToken: true);
      Map<String, dynamic> body = jsonDecode(response);
      SaleProduct newSaleProduct = SaleProduct.fromJson(body);
      return newSaleProduct;
    } catch (e) {
      log("Error creating sale product: $e");
      return null;
    }
  }

  Future<SaleProduct?> updateSaleProduct(SaleProduct saleProduct, int saleId) async {
    try {
      String response = await BaseApi.patch(
          "$salesEndpoint/$saleId/products/${saleProduct.productId}", saleProduct.toJson(),
          withToken: true);
      Map<String, dynamic> body = jsonDecode(response);
      SaleProduct updatedSaleProduct = SaleProduct.fromJson(body);
      return updatedSaleProduct;
    } catch (e) {
      log("Error updating sale product: $e");
      return null;
    }
  }

  Future<bool> deleteSaleProduct(int saleId, int productId) async {
    try {
      await BaseApi.delete("$salesEndpoint/$saleId/products/$productId", {}, withToken: true);
      return true;
    } catch (e) {
      log("Error deleting sale product: $e");
      return false;
    }
  }

  Future<DocumentSale?> getSaleDocument(int saleId) async {
    try {
      String response = await BaseApi.get("$salesEndpoint/$saleId/documents", withToken: true);
      Map<String, dynamic> body = jsonDecode(response);
      DocumentSale documentSale = DocumentSale.fromJson(body);
      return documentSale;
    } catch (e) {
      log("Error getting sale document: $e");
      return null;
    }
  }

  Future<DocumentSale?> uploadSaleDocument(DocumentSale documentSale, int saleId) async {
    try {
      String response = await BaseApi.post("$salesEndpoint/$saleId/documents", documentSale.toJson(), withToken: true);
      Map<String, dynamic> body = jsonDecode(response);
      DocumentSale uploadedDocumentSale = DocumentSale.fromJson(body);
      return uploadedDocumentSale;
    } catch (e) {
      log("Error updating sale document: $e");
      return null;
    }
  }

  Future<bool> deleteSaleDocument(int saleId, int saleDocumentId) async {
    try {
      await BaseApi.delete("$salesEndpoint/$saleId/documents/$saleDocumentId", {}, withToken: true);
      return true;
    } catch (e) {
      log("Error deleting sale document: $e");
      return false;
    }
  }

  Future<ScanModel?> createScan(ScanModel scan, int saleId) async {
    try {
      String response = await BaseApi.post("$salesEndpoint/$saleId/scans", scan.toJson(), withToken: true);
      Map<String, dynamic> body = jsonDecode(response);
      ScanModel newScan = ScanModel.fromJson(body);
      return newScan;
    } catch (e) {
      log("Error creating scan: $e");
      return null;
    }
  }

  Future<List<ScanModel?>> getScans(int saleId) async {
    try {
      String response = await BaseApi.get("$salesEndpoint/$saleId/scans", withToken: true);
      List<ScanModel> scans = scanModelFromJson(response);
      return scans;
    } catch (e) {
      log("Error getting scan: $e");
      return [];
    }
  }

  Future<SaleModel?> createSaleWithDetails(SaleModel sale) async {
    try {
      if (!sale.hasAllArguments()) throw Exception("Sale does not have all required arguments");

      String response = await BaseApi.post("$salesEndpoint/with-details", sale.toJson(), withToken: true);
      Map<String, dynamic> body = jsonDecode(response);
      SaleModel newSale = SaleModel.fromJson(body);
      return newSale;
    } catch (e) {
      log("Error creating sale with details: $e");
      return null;
    }
  }
}
