import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

class SimpleListTile extends StatelessWidget {
  final String? state;
  final List<String>? labels;
  final Color? stateColor;
  final String? title;
  final String noTitle;
  final String? subtitle;
  final String noSubtitle;
  final String? trailing;
  final VoidCallback? onTap;
  final IconData leadingIcon;

  const SimpleListTile({
    super.key,
    this.state,
    this.labels,
    this.stateColor,
    this.title,
    this.noTitle = "Sin título",
    this.subtitle,
    this.noSubtitle = "Sin subtítulo",
    this.trailing,
    this.onTap,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          state != null
              ? Text(state!,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: stateColor ?? TColors.background60,
                      ))
              : const SizedBox(),
          Text(title ?? noTitle, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
      subtitle: Text(subtitle ?? noSubtitle,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: TColors.background60)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (labels != null)
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 200),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: labels!.map((label) {
                  return Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: TColors.background60,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(label,
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: TColors.accentDefault,
                            )),
                  );
                }).toList(),
              ),
            ),
          Text(trailing ?? "", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: TColors.background60)),
        ],
      ),
      onTap: onTap,
    );
  }
}
