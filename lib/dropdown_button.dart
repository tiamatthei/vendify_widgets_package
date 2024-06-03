import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

class SimpleDropdown extends StatefulWidget {
  final IconData? icon;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final String? hintText;
  final String? label;
  final FocusNode? focusNode;
  final void Function(String?)? onChanged;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final bool enabled;

  const SimpleDropdown(
      {super.key,
      this.constraints,
      this.margin,
      this.icon,
      this.hintText,
      this.label,
      this.focusNode,
      this.onChanged,
      this.value,
      this.items,
      this.enabled = true});

  @override
  State<SimpleDropdown> createState() => _SimpleDropdownState();
}

class _SimpleDropdownState extends State<SimpleDropdown> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
        heightFactor: 1,
        alignment: Alignment.center,
        child: Container(
          margin: widget.margin,
          constraints: widget.constraints ?? BoxConstraints.tightFor(width: width),
          child: DropdownButtonFormField2(
            decoration: InputDecoration(
              alignLabelWithHint: true,
              prefixIconColor: MaterialStateColor.resolveWith((states) {
                //if the state is anything but clicked, return the default color
                if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
                  return TColors.accentDefault;
                }
                return TColors.background60;
              }),
              prefixIcon: widget.icon != null ? Icon(widget.icon, size: 20.0) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: TColors.accentDefault,
                  width: 1,
                ),
              ),
              hintText: widget.hintText,
              label: widget.label != null ? Text(widget.label!) : null,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              enabled: widget.enabled,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down_rounded),
              iconDisabledColor: TColors.background60,
              iconEnabledColor: TColors.accentDefault,
            ),
            focusNode: widget.focusNode,
            items: widget.items,
            onChanged: widget.onChanged,
          ),
        ));
  }
}
