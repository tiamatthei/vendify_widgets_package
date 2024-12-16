class SaleProduct {
  SaleProduct({
    this.saleProductId = 0,
    required this.productId,
    required this.discount,
    required this.quantity,
    required this.totalValue,
    this.createAt,
    this.updatedAt,
  });

  int saleProductId;
  int productId;
  double discount;
  int quantity;
  double totalValue;
  DateTime? createAt;
  DateTime? updatedAt;

  factory SaleProduct.fromJson(Map<String, dynamic> json) => SaleProduct(
        saleProductId: json["saleProductId"],
        productId: json["productId"],
        discount: json["discount"],
        quantity: json["quantity"],
        totalValue: json["totalValue"],
        createAt: DateTime.parse(json["createAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
  Map<String, dynamic> toJson() => {
        "saleProductId": saleProductId,
        "productId": productId,
        "discount": discount,
        "quantity": quantity,
        "totalValue": totalValue,
        "createAt": createAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
  @override
  String toString() {
    return 'SaleProduct{saleProductId: $saleProductId, productId: $productId, discount: $discount, quantity: $quantity, totalValue: $totalValue, createAt: $createAt, updatedAt: $updatedAt}';
  }
}
