import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/colors.dart';

class SimpleSubtitle extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isLoading;
  final List<Widget> trailing;
  const SimpleSubtitle(
      {super.key, required this.title, required this.icon, this.isLoading = false, this.trailing = const []});

  @override
  State<SimpleSubtitle> createState() => _SimpleSubtitleState();
}

class _SimpleSubtitleState extends State<SimpleSubtitle> {
  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.start,
      children: [
        Icon(
          widget.icon,
          color: TColors.primaryDefault,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge,
          overflow: TextOverflow.ellipsis,
        ),
        if (widget.isLoading) const SizedBox(width: 10),
        if (widget.isLoading) const CircularProgressIndicator(),
        if (widget.trailing.isNotEmpty) const SizedBox(width: 10),
        ...widget.trailing,
      ],
    );
  }
}
