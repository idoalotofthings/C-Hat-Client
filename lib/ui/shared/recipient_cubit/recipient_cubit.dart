import 'package:c_hat/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipientCubit extends Cubit<User?> {
  User? _value;
  RecipientCubit([this._value]) : super(_value);

  set value(User? newValue) {
    _value = newValue;
    emit(_value);
  }

  User? get value => _value;
}
