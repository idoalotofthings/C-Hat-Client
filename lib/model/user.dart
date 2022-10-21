import 'dart:convert';

class User {

  String username;
  String clientId;
  String? password;

  User(this.username, this.clientId, {this.password});

  factory User.fromJson(String json){
    Map jsonData = jsonDecode(json);
    return User(jsonData["username"], jsonData["client_id"]);
  }

  String toJson(){
    return '{ "username": "$username", "client_id": "$clientId","password" : "$password"}';
  }

}