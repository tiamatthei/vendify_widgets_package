import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendify_widgets_package/colors.dart';

class SimpleFormInput extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final String? hintText;
  final String? initialValue;
  final bool isRequired;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? margin;
  final List<TextInputFormatter>? inputFormatters;

  const SimpleFormInput({
    super.key,
    this.onChanged,
    required this.label,
    this.initialValue,
    this.isRequired = false,
    this.validator,
    this.maxLines,
    this.maxLength,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.margin,
    this.hintText,
    this.inputFormatters,
  });

  @override
  State<SimpleFormInput> createState() => _SimpleFormInputState();
}

class _SimpleFormInputState extends State<SimpleFormInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: widget.hintText,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: TColors.accentDefault),
            borderRadius: BorderRadius.circular(10),
          ),
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
        ),
        style: const TextStyle(color: Colors.black, fontSize: 14),
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
