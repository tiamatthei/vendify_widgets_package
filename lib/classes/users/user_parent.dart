abstract class UserParent {
  int userId;
  int? tenantId;
  String? email;
  String? rut;
  String? firstName;
  String? lastName;
  String? phone;
  String? role;
  String? enrollState;
  String? description;
  int? score;
  String? profileImage;
  DateTime? lastLogin;
  DateTime? joinedAt;
  bool? isActive;
  String? jwt;

  UserParent({
    required this.userId,
    this.tenantId,
    this.email,
    this.rut,
    this.firstName,
    this.lastName,
    this.phone,
    this.role,
    this.enrollState,
    this.description,
    this.score,
    this.profileImage,
    this.lastLogin,
    this.joinedAt,
    this.isActive,
    this.jwt,
  });

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'tenant_id': tenantId,
        'email': email,
        'rut': rut,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'role': role,
        'enroll_state': enrollState,
        'description': description,
        'score': score,
        'profile_image': profileImage,
        'last_login': lastLogin?.toIso8601String(),
        'joined_at': joinedAt?.toIso8601String(),
        'is_active': isActive,
      };

  Future<bool> checkUser();

  Future<void> logout();
}