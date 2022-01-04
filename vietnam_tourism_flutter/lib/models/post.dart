import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
class Post{ 
  int id=0;
  int ownerId=0;
  int placeId=0;
  DateTime time=DateTime.now();
  String content="";
  String imageName="";

  //Save accountId liked, disliked comment 
  List<int> likeds = [];
  List<int> dislikeds = [];

  List<Comment> comments = [];
  String? referenceId;

  Post(this.id, this.ownerId, this.placeId,this.time, this.content, this.imageName, this.likeds, this.dislikeds,this.comments,{this.referenceId});

  factory Post.fromJson(Map<String,dynamic> json) => _postFromJson(json);
  Map<String,dynamic> toJson()=> _postToJson(this);
}

Post _postFromJson(Map<String,dynamic> json){
  return Post(
    json["id"] as int,
    json["ownerId"] as int,
    json["placeId"] as int,
    (json["time"] as Timestamp).toDate(),
    json["content"] as String,
    json["imageName"] as String,
    json["likeds"] as List<int>,
    json["dislikeds"] as List<int>,
    (json["comments"] as List<dynamic>).map((comment) => 
      Comment(
        comment["accountId"] as int,
        comment["content"] as String,
        (comment["time"] as Timestamp).toDate(),
        comment["likeds"] as List<int>,
        comment["dislikeds"] as List<int>,
      )
    ).toList(),
  );
}

Map<String,dynamic> _postToJson(Post post){
  return <String,dynamic>{
    "id":post.id,
    "ownerId":post.ownerId,
    "placeId":post.placeId,
    "time":post.time,
    "content":post.content,
    "imageName":post.imageName,
    "likeds":post.likeds,
    "dislikeds":post.dislikeds,
    "comments":post.comments.map((e) => e.toJson()).toList(),
  };
}

