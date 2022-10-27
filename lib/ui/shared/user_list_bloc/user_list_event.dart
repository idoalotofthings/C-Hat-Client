import 'package:c_hat/model/user.dart';

abstract class UserListEvent {}

class UserAddEvent extends UserListEvent {
  final User user;
  UserAddEvent(this.user);
}
