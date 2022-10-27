import 'package:c_hat/model/user.dart';
import 'package:c_hat/ui/shared/user_list_bloc/user_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListBloc extends Bloc<UserListEvent, List<User>> {
  List<User> value;

  UserListBloc({required this.value}) : super(value) {
    on<UserAddEvent>(((event, emit) {
      value.add(event.user);
      emit(List.from(value));
    }));
  }
}
