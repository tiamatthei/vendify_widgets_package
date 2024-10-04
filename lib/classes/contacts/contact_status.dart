class ContactStatus {
  int? statusId;
  int? tenantId;
  String? status;
  bool? isActive;

  ContactStatus({
    this.statusId,
    this.tenantId,
    this.status,
    this.isActive,
  });

  factory ContactStatus.fromJson(Map<String, dynamic> json) {
    return ContactStatus(
      statusId: json['statusId'],
      tenantId: json['tenantId'],
      status: json['status'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusId': statusId,
      'tenantId': tenantId,
      'status': status,
      'isActive': isActive,
    };
  }
}
