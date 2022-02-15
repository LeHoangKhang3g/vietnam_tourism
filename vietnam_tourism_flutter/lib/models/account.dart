import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
class Account {
  int id =0;
  String username ="";
  String password ="";
  String name="";
  DateTime birthday;
  String email="";
  String avatar="";
  String background="";
  
  Iterable<Post> posts = [];
    
  Account(this.id, this.username, this.password, this.name, this.birthday, this.email, this.avatar, this.background);

  factory Account.fromJson(dynamic json)=>_accountFromJson(json);
  Map<String,dynamic> toJson()=>_accountToJson(this);
}

Account _accountFromJson(dynamic json){
  return Account(
    json["id"] as int,
    json["username"] as String,
    json["password"] as String,
    json["name"] as String,
    DateTime.parse(json["birthday"]),
    json["email"] as String,
    json["avatar"] as String,
    json["background"] as String,
  );
}

Map<String,dynamic> _accountToJson(Account account){
  return <String,dynamic>{
    "id":account.id,
    "username":account.username,
    "password":account.password,
    "name":account.name,
    "birthday":account.birthday.toIso8601String(),
    "email":account.email,
    "avatar":account.avatar,
    "background":account.background,
  };
}
