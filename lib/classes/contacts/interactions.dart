import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/contacts/interaction_type.dart';

class Interaction {
  int interactionId;
  int contactId;
  int userId;
  bool? seen;
  String? previousState;
  String? newState;
  DateTime timestamp;
  String? comments;
  double? latitude;
  double? longitude;
  InteractionType type;
  String? userFirstName;
  String? userLastName;
  String? userPhone;
  String? userEmail;
  String? contactName;
  String? contactBusinessName;
  String? contactPhone;
  String? contactEmail;
  String? contactRut;
  String? contactCity;
  String? contactStreetName;
  String? contactStreetNumber;

  Interaction({
    required this.interactionId,
    required this.contactId,
    required this.userId,
    this.seen,
    this.previousState,
    this.newState,
    required this.timestamp,
    this.comments,
    this.latitude,
    this.longitude,
    required this.type,
    this.userFirstName,
    this.userLastName,
    this.userPhone,
    this.userEmail,
    this.contactName,
    this.contactBusinessName,
    this.contactPhone,
    this.contactEmail,
    this.contactRut,
    this.contactCity,
    this.contactStreetName,
    this.contactStreetNumber,
  });

  factory Interaction.fromJson(Map<String, dynamic> json) => Interaction(
        interactionId: json["interactionId"],
        contactId: json["contactId"],
        userId: json["userId"],
        seen: json["seen"],
        previousState: json["previousState"],
        newState: json["newState"],
        timestamp: DateTime.parse(json["timestamp"]),
        comments: json["comments"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        type: InteractionType.fromJson({
          "interactionTypeId": json["typeId"],
          "interactionType": json["interactionType"],
        }),
        userFirstName: json["userFirstName"],
        userLastName: json["userLastName"],
        userPhone: json["userPhone"],
        userEmail: json["userEmail"],
        contactName: json["contactName"],
        contactBusinessName: json["contactBusinessName"],
        contactPhone: json["contactPhone"],
        contactEmail: json["contactEmail"],
        contactRut: json["contactRut"],
        contactCity: json["contactCity"],
        contactStreetName: json["contactStreetName"],
        contactStreetNumber: json["contactStreetNumber"],
      );

  Map<String, dynamic> toJson() => {
        "interactionId": interactionId,
        "contactId": contactId,
        "userId": userId,
        "seen": seen,
        "previousState": previousState,
        "newState": newState,
        "timestamp": timestamp.toIso8601String(),
        "comments": comments,
        "latitude": latitude,
        "longitude": longitude,
        "typeId": type.typeId,
        "interactionType": type.interactionType,
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userPhone": userPhone,
        "userEmail": userEmail,
        "contactName": contactName,
        "contactBusinessName": contactBusinessName,
        "contactPhone": contactPhone,
        "contactEmail": contactEmail,
        "contactRut": contactRut,
        "contactCity": contactCity,
        "contactStreetName": contactStreetName,
        "contactStreetNumber": contactStreetNumber,
      };

  Widget asDetailsListTile(BuildContext context) {
    return ListTile(
      title: Text(comments ?? ""),
      subtitle: Text(timestamp.toString()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            type.interactionType ?? "",
            style: TextStyle(color: type.interactionColor),
          ),
          Text("$userFirstName $userLastName"),
        ],
      ),
    );
  }
}
