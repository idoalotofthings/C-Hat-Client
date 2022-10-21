import 'package:c_hat/const/result.dart';
import 'package:c_hat/livedata/livedata.dart';
import 'package:c_hat/model/message.dart';
import 'package:c_hat/model/user.dart';
import 'package:c_hat/network/websocket_client.dart';

class ChatViewModel {
  
  static ChatViewModel? _instance;

  final MutableLiveData<List<Message>> message = MutableLiveData<List<Message>>();
  final MutableLiveData<User?> recipient = MutableLiveData<User?>();
  final MutableLiveData<User?> _user = MutableLiveData<User?>();
  final MutableLiveData<String> _url = MutableLiveData<String>();

  late ChatWebSocketClient wsClient; 

  ChatViewModel._privateConstructor(String serverIP, User loggedInUser) {
    _url.value = serverIP;
    _user.value = loggedInUser;
  }

  static ChatViewModel init(serverIP, loggedInUser) {
    if(_instance == null) {
      _instance = ChatViewModel._privateConstructor(serverIP, loggedInUser);
      return _instance!;
    } else {
      throw Exception("ViewModel has already been initialized, use ViewModel.getInstance()");
    }
  }

  static ChatViewModel? getInstance() => _instance;
  
  LiveData get url => _url;
  LiveData get user => _user;
  
  void _addMessage(Message message) {
    List<Message> tempList = [];
    for(Message i in this.message.value?? []) {
      tempList.add(i);
    }

    tempList.add(message);
    this.message.value = tempList;
  }

  void sendMessage(Message message){
    wsClient.sendMessage(message);
    _addMessage(message);
  }
  
  Future<Result> login(User user) async {
    wsClient = ChatWebSocketClient(_url.value!);
    listen();
    if(_user.value!.username == "Swastik") {
      recipient.value = User("Mummy", "FF2");
    } else if (_user.value!.username == "Mummy"){
      print("Ok");
      recipient.value = User("Swastik", "FF1");
    } else {}
    return await wsClient.login(user);
  }

  void listen() => wsClient.listen();

}

