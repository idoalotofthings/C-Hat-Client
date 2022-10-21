import 'dart:convert';

class Message {

  String content;
  String author;
  String time;
  String recipientClientId;

  Message(this.content, this.author, this.time, this.recipientClientId);

  factory Message.fromJson(String json) {
    Map jsonData = jsonDecode(json);
    return Message(jsonData["message"], jsonData["author"], jsonData["time"], jsonData["rcid"]);
  }

  String toJson(){
    return '{ "message": "$content", "author": "$author", "time": "$time", "rcid":"$recipientClientId" }';
  }

  @override
  String toString(){
    return content;
  }

}