import 'package:flutter/material.dart';
import 'package:vendify_widgets_package/class_widgets/user_tiny_card.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String? description;
  final String? phone;
  final String? role;
  final String? email;
  final DateTime? createdAt;
  final Image? profilePicture;
  Future<Map<String, dynamic>>? userTasks;
  final int? contactCount;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.description,
    this.phone,
    this.role,
    required this.email,
    required this.createdAt,
    required this.profilePicture,
    this.userTasks,
    this.contactCount,
  });

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
    final difference = now.difference(createdAt ?? now);
    final ageInYears = (difference.inDays / 365).floor();
    return ageInYears;
  }

  // Method to convert the User object to a JSON map
  Map<String, dynamic> toJson() => {
        'userId': id,
        'firstName': firstName,
        'lastName': lastName,
        'description': description,
        'phone': phone,
        'role': role,
        'email': email,
        'joinedAt': createdAt != null ? createdAt!.toIso8601String() : '',
        'contactCount': contactCount ?? 0,
      };

  // Method to create a User object from a JSON map
  static User fromJson(Map<String, dynamic> json) => User(
        id: json['userId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        description: json['description'],
        phone: json['phone'],
        role: json['role'] ?? 'executive',
        email: json['email'],
        createdAt: json['joinedAt'] != null ? DateTime.parse(json['joinedAt']) : DateTime.now(),
        contactCount: json['contactCount'] != null ? int.tryParse(json['contactCount']) : 0,
        profilePicture:
            null, // TODO: Add profile picture, should be added to the JSON map when the user data is fetched from the API, even tho its a different endpoint
      );

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, description: $description, phone: $phone, role: $role, email: $email, createdAt: $createdAt, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.firstName == firstName &&
        other.email == email &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ firstName.hashCode ^ email.hashCode ^ createdAt.hashCode;
  }
}
