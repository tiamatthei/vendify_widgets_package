import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/class_widgets/user_tiny_card.dart';
import 'package:vendify_widgets_package/classes/users/user_parent.dart';

class User extends UserParent {
  Future<Map<String, dynamic>>? userTasks;
  final int? contactCount;

  User({
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
    this.userTasks,
    this.contactCount,
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

  Widget taskSummaryView(BuildContext context) {
    //The task summary view should be a card with the number of overdue tasks and the number of tasks for today(the completed ones and the ones that are not completed)
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<Object>(
                future: userTasks,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return Container();
                  }
                  return Container();
                }),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<Object>(
                future: userTasks,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return Container();
                  }
                  return Container();
                }),
          ),
        ),
      ],
    );
  }

  Widget tinyCard(BuildContext context, VoidCallback onTap) {
    return UserTinyCard(user: this, onTap: onTap);
  }
  ///////////////////////
  /////    UTILS   //////
  ///////////////////////

  // Method to check if the user's email is valid
  bool isEmailValid() {
    // Add your email validation logic here
    // For example, you can use regular expressions to validate the email format
    return true; // Replace with your validation logic
  }

  // Method to get the user's age based on the createdAt date
  int getAge() {
    final now = DateTime.now();
    final difference = now.difference(joinedAt ?? now);
    final ageInYears = (difference.inDays / 365).floor();
    return ageInYears;
  }

  // Method to convert the User object to a JSON map
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'description': description,
        'phone': phone,
        'role': role,
        'email': email,
        'joinedAt': joinedAt != null ? joinedAt!.toIso8601String() : '',
        'contactCount': contactCount ?? 0,
      };

  // Method to create a User object from a JSON map
  static User fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        description: json['description'],
        phone: json['phone'],
        role: json['role'] ?? 'executive',
        email: json['email'],
        joinedAt: json['joinedAt'] != null ? DateTime.parse(json['joinedAt']) : DateTime.now(),
        contactCount: json['contactCount'] != null ? int.tryParse(json['contactCount']) : 0,
        profileImage:
            "", // TODO: Add profile picture, should be added to the JSON map when the user data is fetched from the API, even tho its a different endpoint
        score:
            0, // TODO: Add score, should be added to the JSON map when the user data is fetched from the API, even tho its a different endpoint
        lastLogin:
            null, // TODO: Add last login, should be added to the JSON map when the user data is fetched from the API, even tho its a different endpoint
        isActive:
            true, // TODO: Add is active, should be added to the JSON map when the user data is fetched from the API, even tho its a different endpoint
        jwt:
            "", // TODO: Add jwt, should be added to the JSON map when the user data is fetched from the API, even tho its a different endpoint
        tenantId: 0,
        rut: "",
        enrollState: "",
      );

  @override
  String toString() {
    return 'User(userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.userId == userId &&
        other.firstName == firstName &&
        other.email == email &&
        other.joinedAt == joinedAt;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ firstName.hashCode ^ email.hashCode ^ joinedAt.hashCode;
  }

  @override
  Future<bool> checkUser() {
    // TODO: implement checkUser
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
