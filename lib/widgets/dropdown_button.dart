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
  final void Function(dynamic)? onChanged;
  final dynamic value;
  final List<DropdownMenuItem<dynamic>>? items;
  final bool enabled;
  final String? Function(dynamic)? validator;
  final bool searchable;

  const SimpleDropdown({
    super.key,
    this.constraints,
    this.margin,
    this.icon,
    this.hintText,
    this.label,
    this.focusNode,
    this.onChanged,
    this.value,
    this.items,
    this.enabled = true,
    this.validator,
    this.searchable = false,
  });

  @override
  State<SimpleDropdown> createState() => _SimpleDropdownState();
}

class _SimpleDropdownState extends State<SimpleDropdown> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
        heightFactor: 1,
        widthFactor: 1,
        alignment: Alignment.center,
        child: Container(
          margin: widget.margin,
          constraints: widget.constraints ?? BoxConstraints.tightFor(width: width),
          child: DropdownButtonFormField2(
            dropdownSearchData: widget.searchable
                ? DropdownSearchData(
                    searchController: searchController,
                    searchInnerWidget: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Buscar...',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: TColors.primary80,
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    searchInnerWidgetHeight: 50,
                  )
                : null,
            onMenuStateChange: widget.searchable
                ? (isOpen) {
                    if (!isOpen) {
                      searchController.clear();
                    }
                  }
                : null,
            decoration: InputDecoration(
              prefixIconColor: WidgetStateColor.resolveWith((states) {
                //if the state is anything but clicked, return the default color
                if (states.contains(WidgetState.focused) || states.contains(WidgetState.pressed)) {
                  return TColors.accentDefault;
                }
                return TColors.background60;
              }),
              prefixIcon: widget.icon != null ? Icon(widget.icon, size: 20.0) : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: TColors.primary80,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: TColors.accentDefault,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: TColors.errorDefault,
                  width: 1,
                ),
              ),
              hintText: widget.hintText,
              label: widget.label != null ? Text(widget.label!) : null,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              enabled: widget.enabled,
              hintStyle: const TextStyle(color: TColors.background60),
              labelStyle: const TextStyle(color: TColors.primary60, fontSize: 14),
              floatingLabelStyle: const TextStyle(color: TColors.primaryDefault),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down_rounded),
              iconDisabledColor: TColors.background60,
              iconEnabledColor: TColors.primaryDefault,
              openMenuIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: TColors.accentDefault,
              ),
            ),
            focusNode: widget.focusNode,
            items: widget.items,
            onChanged: widget.onChanged,
            validator: widget.validator,
            isExpanded: true,
            value: widget.value,
          ),
        ));
  }
}
