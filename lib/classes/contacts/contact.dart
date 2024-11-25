import 'dart:convert';

import 'package:vendify_widgets_package/classes/contacts/contact_state.dart';
import 'package:vendify_widgets_package/classes/contacts/contact_status.dart';
import 'package:vendify_widgets_package/classes/tasks/task.dart';
import 'package:vendify_widgets_package/classes/users/user.dart';

List<ContactModel> contactModelFromJson(String str) =>
    List<ContactModel>.from(json.decode(str).map((x) => ContactModel.fromJson(x)));

String contactModelToJson(List<ContactModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactModel {
  ContactModel(
      {required this.contactId,
      this.contactName,
      this.phone,
      this.email,
      this.rut,
      this.city,
      this.country,
      this.region,
      this.street,
      this.number,
      this.apartment,
      this.state,
      this.updatedAt,
      this.validated,
      required this.createdAt,
      this.latitude,
      this.longitude,
      this.labels,
      this.isPending,
      this.executive,
      this.notes,
      this.businessName,
      this.isInterested,
      this.executiveLatitude,
      this.executiveLongitude,
      this.status,
      this.completedTasksCount,
      this.rejectedTasksCount,
      this.pendingTasksCount,
      this.totalTasksCount,
      this.completedDocumentsCount,
      this.rejectedDocumentsCount,
      this.pendingDocumentsCount,
      this.totalDocumentsCount,
      this.completedAdminTasksCount,
      this.rejectedAdminTasksCount,
      this.pendingAdminTasksCount,
      this.completedExecutiveTasksCount,
      this.rejectedExecutiveTasksCount,
      this.pendingExecutiveTasksCount,
      this.totalRequestsCount,
      this.completedRequestsCount,
      this.rejectedRequestsCount,
      this.pendingRequestsCount,
      });

  int contactId;
  String? contactName;
  String? phone;
  String? email;
  String? rut;
  String? city;
  String? country;
  String? region;
  String? street;
  String? number;
  String? apartment;
  ContactState? state;
  DateTime? updatedAt;
  bool? validated;
  DateTime createdAt;
  double? latitude;
  double? longitude;
  List<String>? labels;
  bool? isPending;
  User? executive;
  String? notes;
  String? businessName;
  bool? isInterested;
  double? executiveLatitude;
  double? executiveLongitude;
  ContactStatus? status;
  int? completedTasksCount;
  int? rejectedTasksCount;
  int? pendingTasksCount;
  int? totalTasksCount;
  int? completedDocumentsCount;
  int? rejectedDocumentsCount;
  int? pendingDocumentsCount;
  int? totalDocumentsCount;
  int? completedAdminTasksCount;
  int? rejectedAdminTasksCount;
  int? pendingAdminTasksCount;
  int? completedExecutiveTasksCount;
  int? rejectedExecutiveTasksCount;
  int? pendingExecutiveTasksCount;
  int? totalRequestsCount;
  int? completedRequestsCount;
  int? rejectedRequestsCount;
  int? pendingRequestsCount;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        contactId: json["contactId"],
        contactName: json["contactName"],
        phone: json["phone"],
        email: json["email"],
        rut: json["rut"],
        city: json["city"],
        country: json["country"],
        region: json["region"],
        street: json["street"],
        number: json["number"]?.toString(),
        apartment: json["apartment"],
        state: ContactState.fromJson(
          {
            "contactStateId": json["contactStateId"],
            "state": json["state"],
            "description": json["description"],
            "step": json["step"],
            "color": json["color"],
            "linkedTasks":
                json["linkedTasks"] == null ? null : List<Task>.from(json["linkedTasks"].map((x) => Task.fromJson(x))),
            "userAdvance": json["userAdvance"],
          },
        ),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        validated: json["validated"],
        createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse(json["createdAt"]),
        latitude: (json["latitude"] as num?)?.toDouble(),
        longitude: (json["longitude"] as num?)?.toDouble(),
        labels: json["labels"] == null ? [] : List<String>.from(json["labels"].map((x) => x.toString())),
        isPending: json["isPending"],
        executive: json["executiveId"] == null
            ? null
            : User.fromJson({
                "userId": json["executiveId"],
                "firstName": json["executiveFirstName"],
                "lastName": json["executiveLastName"],
                "email": json["executiveEmail"],
                "phone": json["executivePhone"],
              }),
        notes: json["notes"],
        businessName: json["businessName"],
        isInterested: json["isInterested"],
        executiveLatitude: (json["executiveLatitude"] as num?)?.toDouble(),
        executiveLongitude: (json["executiveLongitude"] as num?)?.toDouble(),
        status: ContactStatus.fromJson({
          "statusId": json["statusId"],
          "tenantId": json["tenantId"],
          "status": json["status"],
          "isActive": json["isActive"],
        }),
        completedTasksCount: json["completedTasksCount"],
        rejectedTasksCount: json["rejectedTasksCount"],
        pendingTasksCount: json["pendingTasksCount"],
        totalTasksCount: json["totalTasksCount"],
        completedDocumentsCount: json["completedDocumentsCount"],
        rejectedDocumentsCount: json["rejectedDocumentsCount"],
        pendingDocumentsCount: json["pendingDocumentsCount"],
        totalDocumentsCount: json["totalDocumentsCount"],
        completedAdminTasksCount: json["completedAdminTasksCount"],
        rejectedAdminTasksCount: json["rejectedAdminTasksCount"],
        pendingAdminTasksCount: json["pendingAdminTasksCount"],
        completedExecutiveTasksCount: json["completedExecutiveTasksCount"],
        rejectedExecutiveTasksCount: json["rejectedExecutiveTasksCount"],
        pendingExecutiveTasksCount: json["pendingExecutiveTasksCount"],
        totalRequestsCount: json["totalRequestsCount"],
        completedRequestsCount: json["completedRequestsCount"],
        rejectedRequestsCount: json["rejectedRequestsCount"],
        pendingRequestsCount: json["pendingRequestsCount"],
      );

  Map<String, dynamic> toJson() => {
        "contactId": contactId,
        "contactName": contactName,
        "phone": phone,
        "email": email,
        "rut": rut,
        "city": city,
        "country": country,
        "region": region,
        "street": street,
        "number": number,
        "apartment": apartment,
        "state": state?.toJson(),
        "updatedAt": updatedAt?.toIso8601String(),
        "validated": validated,
        "createdAt": createdAt.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "labels": labels == null ? [] : List<dynamic>.from(labels!.map((x) => x.toString())),
        "isPending": isPending,
        "notes": notes,
        "businessName": businessName,
        "isInterested": isInterested,
        "executiveLatitude": executiveLatitude,
        "executiveLongitude": executiveLongitude,
        "status": status?.toJson(),
        "completedTasksCount": completedTasksCount,
        "rejectedTasksCount": rejectedTasksCount,
        "pendingTasksCount": pendingTasksCount,
        "totalTasksCount": totalTasksCount,
        "completedDocumentsCount": completedDocumentsCount,
        "rejectedDocumentsCount": rejectedDocumentsCount,
        "pendingDocumentsCount": pendingDocumentsCount,
        "totalDocumentsCount": totalDocumentsCount,
        "completedAdminTasksCount": completedAdminTasksCount,
        "rejectedAdminTasksCount": rejectedAdminTasksCount,
        "pendingAdminTasksCount": pendingAdminTasksCount,
        "completedExecutiveTasksCount": completedExecutiveTasksCount,
        "rejectedExecutiveTasksCount": rejectedExecutiveTasksCount,
        "pendingExecutiveTasksCount": pendingExecutiveTasksCount,
        "totalRequestsCount": totalRequestsCount,
        "completedRequestsCount": completedRequestsCount,
        "rejectedRequestsCount": rejectedRequestsCount,
        "pendingRequestsCount": pendingRequestsCount,
      };

  @override
  String toString() {
    return 'ContactModel{contactId: $contactId, contactName: $contactName, phone: $phone, email: $email, rut: $rut, city: $city, region: $region, street: $street, number: $number, state: $state, updatedAt: $updatedAt, validated: $validated, createdAt: $createdAt, latitude: $latitude, longitude: $longitude, labels: $labels, isPending: $isPending, executiveLatitude: $executiveLatitude, executiveLongitude: $executiveLongitude, executive: $executive}';
  }
}
