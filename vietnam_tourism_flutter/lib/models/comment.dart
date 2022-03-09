import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';

class Comment {
  int id;
  int accountId=0;
  String typePost="";
  int postId=0;
  String content="";
  DateTime time =DateTime.now();



  //Save accountId liked, disliked comment 
  Iterable<Status> status = [];

  Comment(this.id,this.accountId,this.typePost, this.postId,this.content,this.time);

  factory Comment.fromJson(dynamic json)=>_commentFromJson(json);

  Map<String,dynamic> toJson() => _commentToJson(this);
}

Comment _commentFromJson(dynamic json){
  return Comment(
    json["id"] as int,
    json["account_id"] as int,
    json["type_post"] as String,
    json["post_id"] as int,
    json["content"] as String,
    DateTime.parse(json["time"]),
  );
}

Map<String,dynamic> _commentToJson(Comment comment){
  return <String,dynamic>{
    "id":comment.id,
    "account_id":comment.accountId,
    "type_post":comment.typePost,
    "post_id":comment.postId,
    "content":comment.content,
    "time":comment.time.toIso8601String(),
  };
}