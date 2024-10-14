import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

enum SimpleModalType { info, confirmation, error, warning, success }

Future<T?> showSimpleModal<T>({
  required BuildContext context,
  required String title,
  required String bodyText,
  Widget? body,
  IconData? topIcon,
  double height = 406,
  double width = 328,
  List<Widget> actions = const [],
  double actionsSpacing = 16,
  SimpleModalType type = SimpleModalType.info,
}) {
  return showDialog<T>(
    context: context,
    barrierColor: TColors.primaryDefault.withOpacity(0.1),
    builder: (BuildContext context) {
      return SimpleModal(
        title: title,
        body: body,
        bodyText: bodyText,
        topIcon: topIcon,
        height: height,
        width: width,
        actions: actions,
        actionsSpacing: actionsSpacing,
        type: type,
      );
    },
  );
}

class SimpleModal extends StatefulWidget {
  final String title;
  final Widget? body;
  final String bodyText;
  final IconData? topIcon;
  final double height;
  final double width;
  final List<Widget> actions;
  final double actionsSpacing;
  final SimpleModalType type;
  const SimpleModal({
    super.key,
    required this.title,
    this.body,
    required this.bodyText,
    this.topIcon,
    this.height = 406,
    this.width = 328,
    required this.actions,
    required this.actionsSpacing,
    required this.type,
  });

  @override
  State<SimpleModal> createState() => _SimpleModalState();
}

class _SimpleModalState extends State<SimpleModal> {
  Alignment widgetsAlignment() {
    switch (widget.type) {
      case SimpleModalType.info:
        return Alignment.centerLeft;
      default:
        return Alignment.center;
    }
  }

  TextAlign textAlignment() {
    switch (widget.type) {
      case SimpleModalType.info:
        return TextAlign.left;
      default:
        return TextAlign.center;
    }
  }

  Color iconColor() {
    switch (widget.type) {
      case SimpleModalType.info:
        return TColors.primaryDefault;
      case SimpleModalType.confirmation:
        return TColors.accentDefault;
      case SimpleModalType.error:
        return TColors.errorDefault;
      case SimpleModalType.warning:
        return TColors.warningDefault;
      case SimpleModalType.success:
        return TColors.successDefault;
    }
  }

  double? iconSize() {
    switch (widget.type) {
      case SimpleModalType.info:
        return null;
      default:
        return 52;
    }
  }

  IconData? icon() {
    if (widget.topIcon != null) return widget.topIcon!;

    switch (widget.type) {
      case SimpleModalType.info:
        return Icons.info;
      case SimpleModalType.confirmation:
        return null;
      case SimpleModalType.error:
        return Icons.highlight_remove_rounded;
      case SimpleModalType.warning:
        return Icons.warning_amber_rounded;
      case SimpleModalType.success:
        return Icons.check_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: TColors.backgroundDefault,
      shadowColor: const Color(0xFF255166),
      // surfaceTintColor: const Color(0xFF255166),
      elevation: 30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.height,
          maxWidth: widget.width,
          minWidth: widget.width,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon() != null
                    ? Align(
                        alignment: widgetsAlignment(),
                        child: Icon(
                          icon(),
                          size: iconSize(),
                          color: iconColor(),
                        ))
                    : const SizedBox(),
                icon() != null ? const SizedBox(height: 16) : const SizedBox(),
                Align(
                  alignment: widgetsAlignment(),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: TColors.primaryDefault,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: widgetsAlignment(),
                  child: Text(
                    widget.bodyText,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: TColors.primary80),
                    textAlign: textAlignment(),
                  ),
                ),
                widget.type == SimpleModalType.info ? const SizedBox(height: 20) : const SizedBox(),
                widget.body ?? const SizedBox(),
                const SizedBox(height: 20),
                Wrap(
                  spacing: widget.actionsSpacing,
                  runSpacing: 4,
                  children: widget.actions.map((action) => action).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
