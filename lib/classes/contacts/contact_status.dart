class ContactStatus {
  int? statusId;
  int? tenantId;
  String? status;
  bool? isActive;

  ContactStatus({
    required this.statusId,
    required this.tenantId,
    required this.status,
    required this.isActive,
  });

  factory ContactStatus.fromJson(Map<String, dynamic> json) {
    return ContactStatus(
      statusId: json['status_id'],
      tenantId: json['tenant_id'],
      status: json['status'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status_id': statusId,
      'tenant_id': tenantId,
      'status': status,
      'is_active': isActive,
    };
  }
}
