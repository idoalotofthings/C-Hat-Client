abstract class LoginState {
  const LoginState();
}

class LoginWait extends LoginState {
  const LoginWait();
}

class LoginSuccess extends LoginState {
  final String clientId;
  final String username;
  LoginSuccess(this.clientId, this.username);
}

class LoginFailed extends LoginState {
  final String message;
  LoginFailed(this.message);
}
