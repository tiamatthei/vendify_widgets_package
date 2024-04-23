import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

class SimpleButton extends StatefulWidget {
  final String? text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final MainAxisSize mainAxisSize;
  final bool isSecondary;
  final MaterialStateProperty<EdgeInsetsGeometry>? padding;
  final bool isLoading;

  const SimpleButton({
    super.key,
    this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.mainAxisSize = MainAxisSize.max,
    this.isSecondary = false,
    this.padding,
    this.isLoading = false,
  });

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
        heightFactor: 1,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                widget.backgroundColor ??
                    (widget.isSecondary ? Colors.white : TColors.accentDefault),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                widget.textColor ??
                    (widget.isSecondary ? TColors.accentDefault : Colors.white),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: widget.isSecondary
                        ? const BorderSide(
                            color: TColors.accentDefault, width: 2)
                        : BorderSide.none),
              ),
              maximumSize: MaterialStateProperty.all<Size>(Size(width, 50)),
              padding: widget.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: widget.mainAxisSize,
            children: widget.isLoading
                ? [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.isSecondary
                              ? TColors.accentDefault
                              : Colors.white,
                        ),
                      ),
                    )
                  ]
                : [
                    if (widget.text != null) Text(widget.text!),
                    if (widget.icon != null)
                      Padding(
                          padding: widget.text != null
                              ? const EdgeInsets.only(left: 8)
                              : EdgeInsets.zero,
                          child: Icon(
                            widget.icon,
                            color: widget.textColor ?? Colors.white,
                          ))
                  ],
          ),
        ));
  }
}
