import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';
class Place{
  int id=0;
  String name="";
  String area="";   //miền 
  String region=""; //khu vực
  String description=""; //Mô tả
  String imageName="";
  double locationX;
  double locationY;

  int likes=0;
  int unlikes=0;
  //Save accountId liked, disliked comment 
  Iterable<Status> status = [];

  Iterable<Comment> comments = [];
  //Save postId share this place

  Place(this.id,this.name, this.area, this.region, this.description, this.imageName, this.locationX, this.locationY);

  factory Place.fromJson(dynamic json)=>_placeFromJson(json);

  Map<String,dynamic> toJson()=>_placeToJson(this);
}

Place _placeFromJson(dynamic json){
  return Place(
    json["id"] as int,
    json["name"] as String,
    json["area"] as String,
    json["region"] as String,
    json["description"] as String,
    json["image_name"] as String,
    json["location_x"] as double,
    json["location_y"] as double,
  );
}

Map<String,dynamic> _placeToJson(Place place){
  return <String,dynamic>{
    "id":place.id,
    "name":place.name,
    "area":place.area,
    "region":place.region,
    "description":place.description,
    "image_name":place.imageName,
    "location_x":place.locationX,
    "location_y":place.locationY,
  };
}


