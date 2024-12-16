import 'dart:convert';

List<ScanModel> scanModelFromJson(String data) =>
    List<ScanModel>.from(json.decode(data).map((x) => ScanModel.fromJson(x)));

class ScanModel {
  int saleScanId;
  int scanId;
  String data;
  double latitude;
  double longitude;
  DateTime? createdAt;
  DateTime? updatedAt;

  ScanModel({
    this.saleScanId = 0,
    this.scanId = 0,
    required this.data,
    required this.latitude,
    required this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
      saleScanId: json["saleScanId"],
      scanId: json["scanId"],
      data: json["data"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null);

  Map<String, dynamic> toJson() => {
        "saleScanId": saleScanId,
        "scanId": scanId,
        "data": data,
        "latitude": latitude,
        "longitude": longitude,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
  @override
  String toString() {
    return 'ScanModel{saleScanId: $saleScanId, scanId: $scanId, data: $data, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
