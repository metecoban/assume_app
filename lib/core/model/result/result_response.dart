class ResultResponse {
  final bool success;
  final String? message;

  ResultResponse({required this.success, this.message});

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };

  static ResultResponse fromJson(Map<String, dynamic> json) => ResultResponse(
      success: json['success'] ?? false, message: json['message'] ?? "");
}
