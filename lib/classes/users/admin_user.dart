import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendify_widgets_package/classes/users/user_parent.dart';
import 'package:vendify_widgets_package/utils/api/auth.dart';

class AdminUser extends UserParent {
  AdminUser({
    required int userId,
    int? tenantId,
    String? email,
    String? rut,
    String? firstName,
    String? lastName,
    String? phone,
    String? role,
    String? enrollState,
    String? description,
    int? score,
    String? profileImage,
    DateTime? lastLogin,
    DateTime? joinedAt,
    bool? isActive,
    String? jwt,
  }) : super(
          userId: userId,
          tenantId: tenantId,
          email: email,
          rut: rut,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          role: role,
          enrollState: enrollState,
          description: description,
          score: score,
          profileImage: profileImage,
          lastLogin: lastLogin,
          joinedAt: joinedAt,
          isActive: isActive,
          jwt: jwt,
        );

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      userId: json['user_id'] ?? 0,
      tenantId: json['tenant_id'],
      email: json['email'],
      rut: json['rut'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      role: json['role'],
      enrollState: json['enroll_state'],
      description: json['description'],
      score: json['score'],
      profileImage: json['profile_image'],
      lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login']) : null,
      joinedAt: json['joined_at'] != null ? DateTime.parse(json['joined_at']) : null,
      isActive: json['is_active'],
      jwt: json['jwt'],
    );
  }

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

  @override
  Future<bool> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      bool success = await AuthApi.login(email, password);
      return success;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
  }
}
