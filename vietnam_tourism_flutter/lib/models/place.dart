import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
class Place{
  int id=0;
  String name="";
  String area="";   //miền 
  String region=""; //khu vực
  String description=""; //Mô tả
  String imageName="";


  //Save accountId liked, disliked comment 
  List<int> likeds = [];
  List<int> dislikeds = [];

  List<Comment> comments = [];
  //Save postId share this place
  List<int> shareIds = [];
  String? referenceId;

  Place(this.id,this.name, this.area, this.region, this.description, this.imageName, this.likeds, this.dislikeds, this.comments, this.shareIds, {this.referenceId});

  factory Place.fromSnapshot(DocumentSnapshot snapshot){
    final pet = Place.fromJson(snapshot.data() as Map<String,dynamic>);
    pet.referenceId=snapshot.reference.id;
    return pet;
  }

  factory Place.fromJson(Map<String,dynamic> json)=>_placeFromJson(json);

  Map<String,dynamic> toJson()=>_placeToJson(this);
}

Place _placeFromJson(Map<String,dynamic> json){
  return Place(
    json["id"] as int,
    json["name"] as String,
    json["area"] as String,
    json["region"] as String,
    json["description"] as String,
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
    json["shareIds"] as List<int>,
  );
}

Map<String,dynamic> _placeToJson(Place place){
  return <String,dynamic>{
    "id":place.id,
    "name":place.name,
    "area":place.area,
    "region":place.region,
    "description":place.description,
    "imageName":place.imageName,
    "likeds":place.likeds,
    "dislikeds":place.dislikeds,
    "comments":place.comments.map((e) => e.toJson()).toList(),
    "shareIds":place.shareIds,
  };
}


