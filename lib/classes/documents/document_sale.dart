class DocumentSale {
  int saleDocumentId;
  int documentId;
  double latitude;
  double longitude;
  DateTime? createdAt;

  DocumentSale({
    this.saleDocumentId = 0,
    required this.documentId,
    required this.latitude,
    required this.longitude,
    this.createdAt,
  });

  factory DocumentSale.fromJson(Map<String, dynamic> json) => DocumentSale(
        saleDocumentId: json["saleDocumentId"],
        documentId: json["documentId"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "saleDocumentId": saleDocumentId,
        "documentId": documentId,
        "latitude": latitude,
        "longitude": longitude,
        "createdAt": createdAt,
      };
  @override
  String toString() {
    return 'DocumentSale{saleDocumentId: $saleDocumentId, documentId: $documentId, latitude: $latitude, longitude: $longitude, createdAt: $createdAt}';
  }
}
