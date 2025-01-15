import 'dart:convert';

List<ProductModel> productModelFromJson(String str) =>
    List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

class ProductModel {
  int productId;
  int catalogId;
  String? name;
  String? barcode;
  String? description;
  double? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductModel({
    required this.productId,
    required this.catalogId,
    this.name,
    this.barcode,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productId: json["productId"],
        catalogId: json["catalogId"],
        name: json["name"],
        barcode: json["barcode"],
        description: json["desription"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": productId,
        "catalogId": catalogId,
        "name": name,
        "barcode": barcode,
        "description": description,
        "price": price,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
  @override
  String toString() {
    return 'ProductModel{productId: $productId, catagolId: $catalogId, name: $name, barcode: $barcode, description: $description, price: $price, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
