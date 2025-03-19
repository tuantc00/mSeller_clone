
import 'package:mseller/model/user_model.dart';

enum Status {
  ok(200),
  badRequest(400),
  unauthorized(401);

  final int code;
  const Status(this.code);

  static Status fromCode(int code) {
    try {
      return Status.values.firstWhere((e) => e.code == code);
    } catch (_) {
      return Status.badRequest;
    }
  }
}

class ApiMessenger {
  final String? type;
  final String? title;
  final Status status;
  final UserModel? userModel;

  const ApiMessenger({
    this.type,
    this.title,
    required this.status,
    this.userModel,
  });

  factory ApiMessenger.fromJson(Map<String, dynamic> json) {
    final statusCode = json['status'] as int? ?? 400;
    final status = Status.fromCode(statusCode);


    UserModel? user;
    if (json['messages'] != null && json['messages'] is Map<String, dynamic>) {
      try {
        user = UserModel.fromJson(json['messages'] as Map<String, dynamic>);
      } catch (e) {
        print('Error parsing user model: $e');
      }
    }

    return ApiMessenger(
      type: json['type'] as String?,
      title: json['title'] as String?,
      status: status,
      userModel: user,
    );
  }
}