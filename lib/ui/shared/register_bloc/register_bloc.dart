import 'dart:convert';

import 'package:c_hat/ui/shared/register_bloc/register_event.dart';
import 'package:c_hat/ui/shared/register_bloc/register_state.dart';
import 'package:c_hat/ui/shared/register_repository/register_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterState value;

  final RegisterRepository repository;

  RegisterBloc(this.repository, {this.value = const RegisterWait()})
      : super(value) {
    on<RegisterSentEvent>((event, emit) {
      emit(const RegisterWait());
      repository.client.channel
        ..sink.add(event.user.toJson("register"))
        ..stream.listen((event) {
          Map jsonData = jsonDecode(event);
          if (jsonData["event"] == "confirmation") {
            if (jsonData["status"] == "done") {
              add(RegisterSuccessEvent());
            } else {
              add(RegisterFailedEvent(jsonData["message"]));
            }
          } else if (jsonData["event"] == "verify") {
            print("object");
            add(RegisterVerifyEvent());
          } else {
            add(RegisterFailedEvent(jsonData["message"]));
          }
        });
    });

    on<OtpSendEvent>((event, emit) {
      repository.client.channel.sink
          .add(jsonEncode({"event": "confirmation", "code": "${event.otp}"}));
    });

    on<RegisterSuccessEvent>((event, emit) {
      emit(RegisterSuccess());
    });

    on<RegisterFailedEvent>((event, emit) {
      emit(RegisterFailed(event.message));
    });

    on<RegisterVerifyEvent>(((event, emit) => emit(RegisterVerify())));
  }
}
