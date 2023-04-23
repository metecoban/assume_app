import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';

part 'user_request.g.dart';

@HiveType(typeId: 1)
class UserRequest {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? password;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? surname;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? otpCode;
  @HiveField(6)
  List? categories;
  @HiveField(7)
  final DateTime? createdAt;

  UserRequest({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.categories,
    this.createdAt,
    this.otpCode,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'categories': categories,
        'createdAt': createdAt ?? DateTime.now(),
        'otpCode': otpCode,
      };

  static UserRequest fromJson(Map<String, dynamic> json) => UserRequest(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      surname: json['surname'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      categories: json['categories'] ?? [],
      otpCode: (json['otpCode'] ?? "").toString(),
      createdAt:
          ((json['createdAt'] ?? Timestamp.now()) as Timestamp).toDate());
}
