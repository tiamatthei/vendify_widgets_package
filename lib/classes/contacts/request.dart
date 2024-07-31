import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/contacts/request_type.dart';
import 'package:vendify_widgets_package/colors.dart';
import 'package:vendify_widgets_package/utils/time_ago.dart';

class Request {
  int requestId;
  int contactId;
  int userId;
  bool? resolved;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? resolvedAt;
  String? notes;
  RequestType type;
  String? contactName;
  String? businessName;
  String? userFirstName;
  String? userLastName;

  Request({
    required this.requestId,
    required this.contactId,
    required this.userId,
    this.resolved,
    required this.createdAt,
    this.updatedAt,
    this.resolvedAt,
    this.notes,
    required this.type,
    this.contactName,
    this.businessName,
    this.userFirstName,
    this.userLastName,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        requestId: json['requestId'],
        contactId: json['contactId'],
        userId: json['userId'],
        resolved: json['resolved'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt']) : null,
        notes: json['notes'],
        type: RequestType.fromJson({
          'type_id': json['requestTypeId'],
          'type_name': json['requestTypeName'],
        }),
        contactName: json['contactName'],
        businessName: json['businessName'],
        userFirstName: json['userFirstName'],
        userLastName: json['userLastName'],
      );

  Map<String, dynamic> toJson() => {
        'requestId': requestId,
        'contactId': contactId,
        'userId': userId,
        'resolved': resolved,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'resolvedAt': resolvedAt?.toIso8601String(),
        'notes': notes,
        'requestTypeId': type.typeId,
        'requestTypeName': type.typeName,
        'contactName': contactName,
        'businessName': businessName,
        'userFirstName': userFirstName,
        'userLastName': userLastName,
      };

  //get resolved
  String get getResolved {
    if (resolved == true) {
      return "RESUELTA";
    } else if (resolved == false) {
      return "NO RESUELTA";
    } else {
      return "EN PROCESO";
    }
  }

  Color get getResolvedColor {
    if (resolved == true) {
      return TColors.success60;
    } else if (resolved == false) {
      return TColors.errorDefault;
    } else {
      return TColors.warningDefault;
    }
  }

  Widget get getResolvedTicket {
    if (resolved == null) {
      return Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: TColors.accentDefault,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text("Pendiente",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            )),
      );
    } else if (resolved == true) {
      return Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: TColors.success60,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text("Aprobada",
            style: TextStyle(
              color: TColors.primaryDefault,
              fontSize: 12,
            )),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: TColors.errorDefault,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text("Rechazada",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            )),
      );
    }
  }

  Widget get getAprovedState {
    if (resolved == true) {
      return Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: TColors.success60,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text("Aprobada",
            style: TextStyle(
              color: TColors.primaryDefault,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
      );
    } else if (resolved == false) {
      return Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: TColors.errorDefault,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text("Rechazada",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: TColors.accentDefault,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text("Pendiente",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
      );
    }
  }

  String get getLastUpdate {
    return DateTime.tryParse(updatedAt.toString()) != null ? timeAgo(DateTime.parse(updatedAt.toString())) : "N/A";
  }

  String get getCreationDate {
    return DateTime.tryParse(createdAt.toString()) != null ? timeAgo(DateTime.parse(createdAt.toString())) : "N/A";
  }

  String get getResolutionDate {
    return DateTime.tryParse(resolvedAt.toString()) != null ? timeAgo(DateTime.parse(resolvedAt.toString())) : "N/A";
  }
}
