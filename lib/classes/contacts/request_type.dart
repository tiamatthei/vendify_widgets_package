import 'package:flutter/material.dart';

class RequestType {
  int? typeId;
  String? typeName;

  RequestType({this.typeId, this.typeName});

  factory RequestType.fromJson(Map<String, dynamic> json) => RequestType(
        typeId: json['type_id'],
        typeName: json['type_name'],
      );

  Map<String, dynamic> toJson() => {
        'type_id': typeId,
        'type_name': typeName,
      };

  Color get color {
    switch (typeName) {
      case 'Técnica':
        return Colors.blue;
      case 'Comercial':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData get icon {
    switch (typeId) {
      case 1:
        return Icons.business_center_sharp;
      case 2:
        return Icons.settings_suggest_outlined;
      default:
        return Icons.contact_page;
    }
  }
}
