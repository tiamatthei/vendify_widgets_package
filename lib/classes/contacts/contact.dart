import 'dart:convert';

import 'package:vendify_widgets_package/classes/user.dart';

List<ContactModel> contactModelFromJson(String str) =>
    List<ContactModel>.from(json.decode(str).map((x) => ContactModel.fromJson(x)));

String contactModelToJson(List<ContactModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactModel {
  ContactModel(
      {required this.contactId,
      this.contactName,
      this.phone,
      this.email,
      this.rut,
      this.city,
      this.country,
      this.region,
      this.street,
      this.number,
      this.apartment,
      this.state,
      this.step,
      this.updatedAt,
      this.validated,
      required this.createdAt,
      this.latitude,
      this.longitude,
      this.labels,
      this.isPending,
      this.executive,
      this.isActive,
      this.notes,
      this.businessName,
      this.isInterested,
      this.executiveLatitude,
      this.executiveLongitude});

  int contactId;
  String? contactName;
  String? phone;
  String? email;
  String? rut;
  String? city;
  String? country;
  String? region;
  String? street;
  String? number;
  String? apartment;
  String? state;
  int? step;
  DateTime? updatedAt;
  bool? validated;
  DateTime createdAt;
  double? latitude;
  double? longitude;
  List<String>? labels;
  bool? isPending;
  User? executive;
  bool? isActive;
  String? notes;
  String? businessName;
  bool? isInterested;
  double? executiveLatitude;
  double? executiveLongitude;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        contactId: json["contactId"],
        contactName: json["contactName"],
        phone: json["phone"],
        email: json["email"],
        rut: json["rut"],
        city: json["city"],
        country: json["country"],
        region: json["region"],
        street: json["street"],
        number: json["number"]?.toString(),
        apartment: json["apartment"],
        state: json["state"].toString(),
        step: json["step"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        validated: json["validated"],
        createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse(json["createdAt"]),
        latitude: (json["latitude"] as num?)?.toDouble(),
        longitude: (json["longitude"] as num?)?.toDouble(),
        labels: json["labels"] == null ? [] : List<String>.from(json["labels"].map((x) => x.toString())),
        isPending: json["isPending"],
        executive: json["executiveId"] == null
            ? null
            : User.fromJson({
                "userId": json["executiveId"],
                "firstName": json["executiveFirstName"],
                "lastName": json["executiveLastName"],
                "email": json["executiveEmail"],
                "phone": json["executivePhone"],
              }),
        isActive: json["isActive"],
        notes: json["notes"],
        businessName: json["businessName"],
        isInterested: json["isInterested"],
        executiveLatitude: json["executiveLatitude"]?.toDouble(),
        executiveLongitude: json["executiveLongitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "contactId": contactId,
        "contactName": contactName,
        "phone": phone,
        "email": email,
        "rut": rut,
        "city": city,
        "country": country,
        "region": region,
        "street": street,
        "number": number,
        "apartment": apartment,
        "state": state,
        "step": step,
        "updatedAt": updatedAt?.toIso8601String(),
        "validated": validated,
        "createdAt": createdAt.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "labels": labels == null ? [] : List<dynamic>.from(labels!.map((x) => x.toString())),
        "isPending": isPending,
        "isActive": isActive,
        "notes": notes,
        "businessName": businessName,
        "isInterested": isInterested,
        "executiveLatitude": executiveLatitude,
        "executiveLongitude": executiveLongitude,
      };

  @override
  String toString() {
    return 'ContactModel{contactId: $contactId, contactName: $contactName, phone: $phone, email: $email, rut: $rut, city: $city, region: $region, street: $street, number: $number, state: $state, step: $step, updatedAt: $updatedAt, validated: $validated, createdAt: $createdAt, latitude: $latitude, longitude: $longitude, labels: $labels, isPending: $isPending, executive: $executive}';
  }
}
