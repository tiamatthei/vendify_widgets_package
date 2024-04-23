import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

class SimpleIconbutton extends StatefulWidget {
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? icon;
  final bool isSecondary;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  const SimpleIconbutton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.icon,
    this.isSecondary = false,
    this.padding,
    this.isLoading = false,
  });

  @override
  State<SimpleIconbutton> createState() => _SimpleIconbuttonState();
}

class _SimpleIconbuttonState extends State<SimpleIconbutton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
      heightFactor: 1,
      child: IconButton(
          onPressed: widget.onPressed,
          icon: widget.isLoading
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: widget.isSecondary
                        ? TColors.accentDefault
                        : Colors.white,
                    backgroundColor: Colors.transparent,
                    strokeWidth: width,
                  ))
              : Icon(
                  widget.icon,
                ),
          color: widget.iconColor ??
              (widget.isSecondary ? TColors.accentDefault : Colors.white),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(widget
                    .backgroundColor ??
                (widget.isSecondary ? Colors.white : TColors.accentDefault)),
            shape: MaterialStateProperty.all(CircleBorder(
                side: widget.isSecondary
                    ? const BorderSide(color: TColors.accentDefault, width: 2)
                    : BorderSide.none)),
            maximumSize: MaterialStateProperty.all<Size>(Size(width, 50)),
          ),
          iconSize: 20,
          padding: widget.padding ?? const EdgeInsets.all(8)),
    );
  }
}
