import 'dart:convert';

import 'package:c_hat/ui/shared/chat_repository/chat_repository.dart';
import 'package:c_hat/ui/shared/login_bloc/login_event.dart';
import 'package:c_hat/ui/shared/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ChatRepository repository;
  LoginState value;


  LoginBloc(this.repository, {this.value = const LoginWait()}) : super(value) {
    on<TryLoginEvent>((event, emit) {
      repository.client.channel.sink.add(event.user.toJson("login"));
      repository.client.stream.listen((event) {
        Map jsonData = jsonDecode(event);
        if (jsonData["event"] == "auth") {
          if (jsonData["status"] == "done") {
            add(LoginSuccessEvent(jsonData["client_id"], jsonData["username"]));
          } else {
            add(LoginFailedEvent(jsonData["message"]));
          }
          
        }
      });
    });

    on<LoginSuccessEvent>((event, emit) => emit(LoginSuccess(event.clientId, event.username)));

    on<LoginFailedEvent>((event, emit) => emit(LoginFailed(event.message)));
  }

}
