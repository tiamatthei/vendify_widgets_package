import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

class LabelChip extends StatelessWidget {
  final String label;

  const LabelChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: _getBackgroundColor(label),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: _getTextColor(label),
            ),
      ),
    );
  }

  Color _getBackgroundColor(String label) {
    switch (label) {
      case "Pendiente":
        return Colors.orange;
      case "Aprobada":
        return Colors.green;
      case "Rechazada":
        return Colors.red;
      case "Ejecutivo":
        return TColors.accentDefault;
      case "Tarea(s) rechazada(s)":
        return Colors.red;
      case "Doc.(s) rechazado(s)":
        return Colors.red;
      case "Tarea(s) pendiente(s)":
        return Colors.orange;
      case "Completado":
        return Colors.green;
      case "Por Aprobar":
        return TColors.accentDefault;
      default:
        return Colors.grey;
    }
  }

  Color _getTextColor(String label) {
    // Customize text color if needed, otherwise return a default color
    return Colors.white;
  }
}
