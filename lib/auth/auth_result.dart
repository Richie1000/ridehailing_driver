import 'package:ridehailing_driver/models/user.dart';

sealed class AuthResult {}

class AuthSuccess extends AuthResult {
  final UserModel user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthResult {
  final String message;
  AuthFailure(this.message);
}
