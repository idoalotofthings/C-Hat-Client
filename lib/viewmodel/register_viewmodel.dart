import 'package:c_hat/const/result.dart';
import 'package:c_hat/livedata/livedata.dart';
import 'package:c_hat/network/websocket_client.dart';

class RegisterViewModel {

  static RegisterViewModel? instance;

  final MutableLiveData<String> _username = MutableLiveData<String>();
  final MutableLiveData<String> _password = MutableLiveData<String>();
  final MutableLiveData<String> _email = MutableLiveData<String>();
  final MutableLiveData<String> _url = MutableLiveData<String>();

  final MutableLiveData<Result> result = MutableLiveData<Result>();
  final MutableLiveData<int> _otp = MutableLiveData<int>();

  late RegisterWebSocketClient wsClient;

  RegisterViewModel._privateConstructor(String username, String password, String mailId, String url) {
    _username.value = username;
    _password.value = password;
    _email.value = mailId;
    _url.value = url;

    registerUser(username, password, mailId);
  }

  static RegisterViewModel init(String username, String password, String mailId, String url){
    if(instance == null) {
      instance = RegisterViewModel._privateConstructor(username, password, mailId, url);
      return instance!;
    } else {
      throw Exception("ViewModel has already been initialized, use ViewModel.getInstance()");
    }
  }

  static RegisterViewModel? getInstance() => instance;

  void registerUser(String username, String password, String mailId) { 
    wsClient = RegisterWebSocketClient(_url.value!);
    wsClient.registerUser(username, password, mailId); 
  }

  void verifyUser(int code){

  }

}