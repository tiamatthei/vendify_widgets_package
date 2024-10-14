class ContactLabel {
  int labelId;
  String label;
  int tenantId;
  String description;
  int? contactStateId;
  bool? isPositive;
  int? relatedLabelId;

  ContactLabel({
    required this.labelId,
    required this.label,
    required this.tenantId,
    required this.description,
    required this.contactStateId,
    this.isPositive,
    this.relatedLabelId,
  });

  factory ContactLabel.fromJson(Map<String, dynamic> json) => ContactLabel(
        labelId: json['contactLabelId'],
        label: json['label'],
        tenantId: json['tenantId'],
        description: json['description'],
        contactStateId: json['contactStateId'],
        isPositive: json['isPositive'],
        relatedLabelId: json['relatedLabelId'],
      );

  Map<String, dynamic> toJson() => {
        'labelId': labelId,
        'label': label,
        'tenantId': tenantId,
        'description': description,
        'contactStateId': contactStateId,
        'isPositive': isPositive,
        'relatedLabelId': relatedLabelId,
      };
}
