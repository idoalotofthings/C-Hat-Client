import 'package:c_hat/model/user.dart';

abstract class RegisterEvent {}

class RegisterSentEvent extends RegisterEvent {
  final User user;
  RegisterSentEvent(this.user);
}

class OtpSendEvent extends RegisterEvent {
  final int otp;
  OtpSendEvent(this.otp);
}

class RegisterSuccessEvent extends RegisterEvent {}

class RegisterVerifyEvent extends RegisterEvent {}

class RegisterFailedEvent extends RegisterEvent {
  final String message;
  RegisterFailedEvent(this.message);
}
