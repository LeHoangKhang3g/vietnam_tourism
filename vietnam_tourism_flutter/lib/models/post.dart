
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';
class Post{ 
  int id=0;
  int accountId=0;
  int placeId=0;
  DateTime time=DateTime.now();
  String content="";
  String imageName="";

  int likes=0;
  int unlikes=0;

  //Save accountId liked, disliked comment 
  Iterable<Status> status = [];

  Iterable<Comment> comments = [];

  Post(this.id, this.accountId, this.placeId,this.time, this.content, this.imageName);

  factory Post.fromJson(Map<String,dynamic> json) => _postFromJson(json);
  Map<String,dynamic> toJson()=> _postToJson(this);
}

Post _postFromJson(Map<String,dynamic> json){
  return Post(
    json["id"] as int,
    json["account_id"] as int,
    json["place_id"] as int,
    DateTime.parse(json["time"]),
    json["content"] as String,
    json["image_name"] as String,
  );
}

Map<String,dynamic> _postToJson(Post post){
  return <String,dynamic>{
    "id":post.id,
    "account_id":post.accountId,
    "place_id":post.placeId,
    "time":post.time.toIso8601String(),
    "content":post.content,
    "image_name":post.imageName,
  };
}

