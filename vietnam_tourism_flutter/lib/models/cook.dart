import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';
class Cook{
  int id=0;
  int placeId=0;
  String name="";
  String description=""; //Mô tả
  String imageName="";

  int likes=0;
  int unlikes=0;
  //Save accountId liked, disliked comment 
  Iterable<Status> status = [];

  Iterable<Comment> comments = [];

  Cook(this.id, this.placeId, this.name, this.description, this.imageName);

  factory Cook.fromJson(dynamic json)=>_cookFromJson(json);

  Map<String,dynamic> toJson()=>_cookToJson(this);
}

Cook _cookFromJson(dynamic json){
  return Cook(
    json["id"] as int,
    json["place_id"] as int,
    json["name"] as String,
    json["description"] as String,
    json["image_name"] as String,
  );
}

Map<String,dynamic> _cookToJson(Cook cook){
  return <String,dynamic>{
    "id":cook.id,
    "place_id":cook.placeId,
    "name":cook.name,
    "description":cook.description,
    "image_name":cook.imageName,
  };
}


