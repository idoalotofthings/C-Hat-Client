import 'dart:convert';

class User {
  String? username;
  String? clientId;
  String? password;
  String mailId;

  User(this.mailId, {this.username, this.clientId, this.password});

  factory User.fromJson(String json) {
    Map jsonData = jsonDecode(json);
    return User(jsonData["mail_id"], username: jsonData["username"],clientId: jsonData["client_id"]);
  }

  String toJson(String event) {
    return '{ "event": "$event", "username": "$username", "client_id": "$clientId","password" : "$password", "mail_id": "$mailId"}';
  }
}
