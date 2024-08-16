import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

class SimpleFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const SimpleFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        label: Text(label),
        labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: selected ? TColors.backgroundDefault : TColors.background60,
            ),
        selected: selected,
        onSelected: onSelected,
        selectedColor: TColors.accentDefault,
        checkmarkColor: TColors.backgroundDefault,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: const BorderSide(
          color: TColors.background60,
          width: 1,
        ));
  }
}
