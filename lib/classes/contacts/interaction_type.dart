import 'package:flutter/material.dart';

class InteractionType {
  int? typeId;
  String? interactionType;

  InteractionType({this.typeId, this.interactionType});

  factory InteractionType.fromJson(Map<String, dynamic> json) => InteractionType(
        typeId: json["typeId"],
        interactionType: json["interactionType"],
      );

  Map<String, dynamic> toJson() => {
        'type_id': typeId,
        'interaction_type': interactionType,
      };

  Color get interactionColor {
    return _getInteractionColor(interactionType);
  }
}

Color _getInteractionColor(interactionType) {
  switch (interactionType) {
    case 'Registro':
      return Colors.green;
    case 'Cambio de estado':
      return Colors.blue;
    case 'Modificación':
      return Colors.orange;
    case 'Completado':
      return Colors.purple;
    default:
      return Colors.black;
  }
}
