import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';

class Comment {
  int accountId=0;
  String content="";
  DateTime time =DateTime.now();

  //Save accountId liked, disliked comment 
  List<int> likeds = [];   
  List<int> dislikeds = [];
  Account? account;
  String? referenceId;

  Comment(this.accountId,this.content,this.time, this.likeds, this.dislikeds,{this.referenceId});

  factory Comment.fromJson(Map<String,dynamic> json)=>_commentFromJson(json);

  Map<String,dynamic> toJson() => _commentToJson(this);
}

Comment _commentFromJson(Map<String,dynamic> json){
  return Comment(
    json["accountId"] as int,
    json["content"] as String,
    (json["time"] as Timestamp).toDate(),
    json["likeds"] as List<int>,
    json["dislikeds"] as List<int>,
  );
}

Map<String,dynamic> _commentToJson(Comment comment){
  return <String,dynamic>{
    "accountId":comment.accountId,
    "content":comment.content,
    "time":comment.time,
    "likeds":comment.likeds,
    "dislikeds":comment.dislikeds,
  };
}