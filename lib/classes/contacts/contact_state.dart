import 'package:vendify_widgets_package/classes/contacts/contact_label.dart';

class ContactState {
  final int contactStateId;
  final String state;
  final String description;
  List<ContactLabel>? linkedLabels;

  ContactState({
    required this.contactStateId,
    required this.state,
    required this.description,
    this.linkedLabels,
  });

  factory ContactState.fromJson(Map<String, dynamic> json) => ContactState(
        contactStateId: json['contactStateId'],
        state: json['state'],
        description: json['description'],
        linkedLabels: json['linkedLabels'] != null
            ? List<ContactLabel>.from(json['linkedLabels'].map((x) => ContactLabel.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'contactStateId': contactStateId,
        'state': state,
        'description': description,
      };
}
