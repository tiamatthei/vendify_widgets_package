class UserGroup {
  int groupId;
  int tenantId;
  String name;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;

  UserGroup({
    required this.groupId,
    required this.tenantId,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserGroup.fromJson(Map<String, dynamic> json) => UserGroup(
        groupId: json['groupId'],
        tenantId: json['tenantId'],
        name: json['groupName'],
        description: json['groupDescription'],
        createdAt: DateTime.parse(json['groupCreatedAt']),
        updatedAt: DateTime.parse(json['groupUpdatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'groupId': groupId,
        'tenantId': tenantId,
        'groupName': name,
        'groupDescription': description,
        'groupCreatedAt': createdAt.toIso8601String(),
        'groupUpdatedAt': updatedAt.toIso8601String(),
      };
}
