import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

Color getContactStateColor(String state) {
  switch (state.toLowerCase()) {
    case 'objetivo':
      return TColors.errorDefault;
    case 'contactado':
      return TColors.warningDefault;
    case 'lead':
      return TColors.accent80;
    case 'prospecto':
      return Colors.lightBlueAccent;
    case 'cliente':
      return TColors.successDefault;
    default:
      return Colors.black;
  }
}
