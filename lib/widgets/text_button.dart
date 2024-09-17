library text_button;

import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

enum SimpleButtonType { primary, secondary, tertiary, destructive, tertiaryDestructive, successDefault }

class SimpleButton extends StatelessWidget {
  /// Botón simple con texto e icono

  /// Texto del botón
  final String? text;

  /// Función que se ejecuta al presionar el botón
  final void Function()? onPressed;

  /// Color de fondo del botón
  final Color? backgroundColor;

  ///Color del texto del botón [text]
  @Deprecated('Usar buttonType')
  final Color? textColor;
  final IconData? icon;
  final MainAxisSize mainAxisSize;

  /// Tipo de botón, ver [SimpleButtonType]
  final SimpleButtonType buttonType;

  /// DEPRECATED: Si el botón es secundario
  @Deprecated('Usar buttonType')
  final bool isSecondary;

  /// Padding interno del botón
  final WidgetStateProperty<EdgeInsetsGeometry>? padding;

  /// Si el botón está cargando, muestra un indicador de carga
  final bool isLoading;

  const SimpleButton({
    super.key,
    this.text,
    this.onPressed,
    this.backgroundColor,
    @Deprecated('Usar buttonType') this.textColor,
    this.icon,
    this.mainAxisSize = MainAxisSize.max,
    @Deprecated('Usar buttonType') this.isSecondary = false,
    this.padding,
    this.isLoading = false,
    this.buttonType = SimpleButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColorResolver() {
      switch (buttonType) {
        case SimpleButtonType.primary:
          return TColors.accentDefault;
        case SimpleButtonType.secondary || SimpleButtonType.tertiary || SimpleButtonType.tertiaryDestructive:
          return TColors.backgroundDefault;
        case SimpleButtonType.destructive:
          return TColors.errorDefault;
        case SimpleButtonType.successDefault:
          return TColors.successDefault;
      }
    }

    Color textColorResolver() {
      switch (buttonType) {
        case SimpleButtonType.primary || SimpleButtonType.destructive || SimpleButtonType.successDefault:
          return Colors.white;
        case SimpleButtonType.secondary || SimpleButtonType.tertiary:
          return TColors.accentDefault;
        case SimpleButtonType.tertiaryDestructive:
          return TColors.errorDefault;
      }
    }

    BorderSide borderResolver() {
      switch (buttonType) {
        case SimpleButtonType.secondary:
          return const BorderSide(color: TColors.accentDefault, width: 2);
        default:
          return BorderSide.none;
      }
    }

    double width = MediaQuery.of(context).size.width;
    return Align(
        heightFactor: 1,
        widthFactor: 1,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(backgroundColorResolver()),
              foregroundColor: WidgetStateProperty.all<Color>(textColorResolver()),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: borderResolver())),
              maximumSize: WidgetStateProperty.all<Size>(Size(width, 50)),
              padding: padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: mainAxisSize,
            children: isLoading
                ? [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(textColorResolver()),
                      ),
                    )
                  ]
                : [
                    if (text != null)
                      Text(text!, style: Theme.of(context).textTheme.labelMedium!.copyWith(color: textColorResolver())),
                    if (icon != null)
                      Padding(
                          padding: text != null ? const EdgeInsets.only(left: 8) : EdgeInsets.zero,
                          child: Icon(
                            icon,
                            color: textColorResolver(),
                          ))
                  ],
          ),
        ));
  }
}
