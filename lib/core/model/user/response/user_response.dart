import 'package:assume/core/model/user/request/user_request.dart';

class UserResponse {
  final bool success;
  final UserRequest? data;
  final String? message;

  UserResponse({required this.success, this.data, this.message});

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data,
        'message': message,
      };

  static UserResponse fromJson(Map<String, dynamic> json) => UserResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? UserRequest.fromJson(json['data']) : null,
      message: json['message'] ?? "");
}
