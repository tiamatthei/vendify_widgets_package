library pill_button;
import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

class PillButton extends StatefulWidget {
  final String? text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final MainAxisSize mainAxisSize;
  final bool isSecondary;
  final WidgetStateProperty<EdgeInsetsGeometry>? padding;
  final bool isLoading;
  final double borderRadius;
  final bool isElevated;
  final bool isLeadingIcon;

  const PillButton({
    super.key,
    this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.mainAxisSize = MainAxisSize.min,
    this.isSecondary = false,
    this.padding,
    this.isLoading = false,
    this.borderRadius = 10,
    this.isElevated = false,
    this.isLeadingIcon = true,
  });

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
      heightFactor: 1,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            widget.backgroundColor ??
                (widget.isSecondary ? Colors.white : TColors.accentDefault),
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            widget.textColor ??
                (widget.isSecondary ? TColors.accentDefault : Colors.white),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              side: widget.isSecondary
                  ? const BorderSide(color: TColors.accentDefault, width: 2)
                  : BorderSide.none,
            ),
          ),
          maximumSize: WidgetStateProperty.all<Size>(Size(width, 50)),
          elevation: widget.isElevated
              ? WidgetStateProperty.all<double>(8)
              : WidgetStateProperty.all<double>(0),
          shadowColor: widget.isElevated
              ? WidgetStateProperty.all<Color>(Colors.black.withOpacity(0.5))
              : null,
          padding: widget.padding ??
              WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: widget.mainAxisSize,
          children: widget.isLoading
              ? [
                  SizedBox(
                    height: 18,
                    width: 19,
                    child: CircularProgressIndicator(
                      color: widget.isSecondary
                          ? TColors.accentDefault
                          : Colors.white,
                      backgroundColor: Colors.transparent,
                      strokeWidth: 2,
                    ),
                  ),
                ]
              : [
                  if (widget.icon != null && widget.isLeadingIcon)
                    Padding(
                      padding: widget.text != null
                          ? const EdgeInsets.only(right: 8.0)
                          : EdgeInsets.zero,
                      child: Icon(
                        widget.icon,
                        color: widget.textColor ?? Colors.white,
                      ),
                    ),
                  if (widget.text != null) Text(widget.text!),
                  if (widget.icon != null && !widget.isLeadingIcon)
                    Padding(
                      padding: widget.text != null
                          ? const EdgeInsets.only(left: 8.0)
                          : EdgeInsets.zero,
                      child: Icon(
                        widget.icon,
                        color: widget.textColor ?? Colors.white,
                      ),
                    ),
                ],
        ),
      ),
    );
  }
}
