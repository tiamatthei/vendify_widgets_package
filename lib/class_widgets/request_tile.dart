import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/contacts/request.dart';
import 'package:vendify_widgets_package/colors.dart';
import 'package:vendify_widgets_package/utils/time_ago.dart';

class RequestTile extends StatefulWidget {
  final Request request;
  final int index;
  final Function(Request request) onSelected;
  final bool isSelected;
  const RequestTile(
      {super.key, required this.request, required this.index, required this.onSelected, required this.isSelected});

  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  // VARIABLES
  String emailText = "";
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.isSelected ? TColors.background80 : Colors.transparent,
      child: ListTile(
        selected: widget.isSelected,
        visualDensity: const VisualDensity(vertical: 2),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 160),
              child: Text("#Solicitud ${widget.request.type.typeName}",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: widget.request.type.color,
                        fontWeight: FontWeight.bold,
                      )),
            ),
            Row(
              children: [
                //if the request is pending is null, it's a new request, show a new label
                widget.request.getResolvedTicket,
                Text(widget.request.contactName ?? "", style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ],
        ),
        subtitle: Text(emailText, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: TColors.background60)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
                widget.request.updatedAt != null
                    ? timeAgo(widget.request.updatedAt!)
                    : timeAgo(widget.request.createdAt),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: TColors.background60)),
            Text("${widget.request.userFirstName} ${widget.request.userLastName}",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: TColors.background60)),
          ],
        ),
        onTap: () {
          widget.onSelected(widget.request);
        },
      ),
    );
  }
}