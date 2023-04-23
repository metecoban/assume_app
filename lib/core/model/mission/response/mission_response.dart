import 'package:assume/core/model/mission/request/mission_request.dart';

class MissionResponse {
  bool? success;
  dynamic data;
  String? message;

  MissionResponse({required this.success, this.data, this.message});

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data,
        'message': message,
      };

  MissionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    if (json['data'] != null) {
      data = <MissionRequest>[];
      json['data'].forEach((v) {
        data!.add(MissionRequest.fromJson(v));
      });
    }
    message = json['message'] ?? "";
  }
}
