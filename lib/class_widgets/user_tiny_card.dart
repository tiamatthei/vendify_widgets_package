import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/classes/users/user.dart';
import 'package:vendify_widgets_package/colors.dart';
import 'package:vendify_widgets_package/widgets/text_button.dart';

class UserTinyCard extends StatefulWidget {
  final User user;
  final VoidCallback? onTap;
  const UserTinyCard({super.key, required this.user, this.onTap});

  @override
  State<UserTinyCard> createState() => _UserTinyCardState();
}

class _UserTinyCardState extends State<UserTinyCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 200) {
        return AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(
              color: TColors.accent60,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                widget.user.profileImage != ""
                    ? CircleAvatar(
                        radius: 30,
                        backgroundImage: Image.network(widget.user.profileImage).image,
                        backgroundColor: TColors.accent60,
                      )
                    : const CircleAvatar(
                        radius: 30,
                        backgroundColor: TColors.accent60,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                Text(
                  "${widget.user.firstName} ${widget.user.lastName}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const Divider(),
                Text(
                  widget.user.email ?? 'S/ email',
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  widget.user.phone ?? 'S/ teléfono',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  widget.user.role ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      }
      return AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(
            color: TColors.accent60,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.user.profileImage != ""
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.network(widget.user.profileImage).image,
                          backgroundColor: TColors.accent60,
                        )
                      : const CircleAvatar(
                          radius: 30,
                          backgroundColor: TColors.accent60,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.user.firstName} ${widget.user.lastName}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.user.email ?? 'S/ email',
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.user.phone ?? 'S/ teléfono',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.user.role ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                child: SimpleButton(
                  onPressed: widget.onTap,
                  text: "Ir a usuario",
                  isSecondary: true,
                  textColor: TColors.accentDefault,
                  icon: Icons.keyboard_arrow_right_rounded,
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
