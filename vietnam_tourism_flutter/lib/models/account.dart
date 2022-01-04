import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
class Account {
  int id =0;
  String username ="";
  String password ="";
  String name="";
  DateTime? birthday;
  String email="";
  String imageName="";
  String background="";
  
  List<Post> posts = [];

  String? referenceId;
    
  Account(this.id, this.username, this.password, this.name, this.birthday, this.email, this.imageName, this.background,this.posts,{this.referenceId});

  factory Account.fromJson(Map<String,dynamic> json)=>_accountFromJson(json);
  Map<String,dynamic> toJson()=>_accountToJson(this);
}

Account _accountFromJson(Map<String,dynamic> json){
  return Account(
    json["id"] as int,
    json["username"] as String,
    json["password"] as String,
    json["name"] as String,
    (json["birthday"] as Timestamp).toDate(),
    json["email"] as String,
    json["imageName"] as String,
    json["background"] as String,
    (json["posts"] as List<dynamic>).map((e) =>
      Post(
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
      ),
    ).toList(),
  );
}

Map<String,dynamic> _accountToJson(Account account){
  return <String,dynamic>{
    "id":account.id,
    "username":account.username,
    "password":account.password,
    "name":account.name,
    "birthday":account.birthday,
    "email":account.email,
    "imageName":account.imageName,
    "background":account.background,
    "posts":account.posts.map((e) => e.toJson()).toList(),
  };
}
