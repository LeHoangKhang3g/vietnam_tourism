import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';
class Stay{
  int id=0;
  int placeId=0;
  String name="";
  String description=""; //Mô tả
  String imageName="";
  double locationX;
  double locationY;

  int likes=0;
  int unlikes=0;
  //Save accountId liked, disliked comment 
  Iterable<Status> status = [];

  Iterable<Comment> comments = [];

  Stay(this.id, this.placeId, this.name, this.description, this.imageName, this.locationX, this.locationY);

  factory Stay.fromJson(dynamic json)=>_stayFromJson(json);

  Map<String,dynamic> toJson()=>_stayToJson(this);
}

Stay _stayFromJson(dynamic json){
  return Stay(
    json["id"] as int,
    json["place_id"] as int,
    json["name"] as String,
    json["area"] as String,
    json["region"] as String,
    json["location_x"] as double,
    json["location_y"] as double,
  );
}

Map<String,dynamic> _stayToJson(Stay stay){
  return <String,dynamic>{
    "id":stay.id,
    "place_id":stay.placeId,
    "name":stay.name,
    "description":stay.description,
    "image_name":stay.imageName,
    "location_x":stay.locationX,
    "location_y":stay.locationY,
  };
}


