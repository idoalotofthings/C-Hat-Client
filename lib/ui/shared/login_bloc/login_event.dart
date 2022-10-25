import 'package:c_hat/model/user.dart';

abstract class LoginEvent {}

class TryLoginEvent extends LoginEvent {
  final User user;
  TryLoginEvent(this.user);
}

class LoginSuccessEvent extends LoginEvent {
  final String clientId;
  final String username;
  LoginSuccessEvent(this.clientId, this.username);
}

class LoginFailedEvent extends LoginEvent {
  final String message;
  LoginFailedEvent(this.message);
}
