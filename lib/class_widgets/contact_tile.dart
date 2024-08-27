import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/contacts/contact.dart';
import 'package:vendify_widgets_package/colors.dart';
import 'package:vendify_widgets_package/utils/contact_state_color.dart';
import 'package:vendify_widgets_package/utils/time_ago.dart';

class ContactTile extends StatefulWidget {
  final ContactModel contact;
  final Function onTapTile;
  final bool isSelected;
  const ContactTile({super.key, required this.contact, required this.onTapTile, required this.isSelected});

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  Color? stateColor;
  String emailText = "";

  @override
  void initState() {
    super.initState();
    if (widget.contact.email != null) {
      emailText = 'Correo: ${widget.contact.email}';
    }
    if (widget.contact.email == null || widget.contact.email == "") {
      emailText = 'No registra email';
    }
    stateColor = getContactStateColor(widget.contact.state!);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.isSelected ? TColors.background80 : Colors.transparent,
      child: ListTile(
        selected: widget.isSelected,
        visualDensity: const VisualDensity(vertical: 2),
        onTap: () {
          widget.onTapTile(widget.contact);
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text("#${widget.contact.state}",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: stateColor,
                          )),
                ),
              ],
            ),
            Row(
              children: [
                //if the contact is pending is null, it's a new contact, show a new label
                if (widget.contact.isPending == null)
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: TColors.accentDefault,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("Nuevo",
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                            )),
                  ),
                Text(
                  widget.contact.contactName ?? "Sin nombre",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: widget.contact.contactName == null ? TColors.error80 : TColors.primaryDefault,
                      ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Text(emailText, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: TColors.background60)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (widget.contact.labels != null)
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.2),
                child: Wrap(children: [
                  ...widget.contact.labels!.map((label) {
                    return Tooltip(
                      message: label,
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, bottom: 2),
                        constraints: const BoxConstraints(maxWidth: 80),
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: TColors.background60,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          label,
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: TColors.accentDefault,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  })
                ]),
              ),
            Text(
                widget.contact.updatedAt != null
                    ? timeAgo(widget.contact.updatedAt!)
                    : timeAgo(widget.contact.createdAt),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: TColors.background60)),
          ],
        ),
      ),
    );
  }
}
