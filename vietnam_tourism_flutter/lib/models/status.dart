import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';

class Status {
  int id;
  int accountId=0;
  String typePost="";
  int postId=0;
  String typeStatus="";

  Status(this.id,this.accountId,this.typePost,this.postId, this.typeStatus);

  factory Status.fromJson(dynamic json)=>_statusFromJson(json);

  Map<String,dynamic> toJson() => _statusToJson(this);
}

Status _statusFromJson(dynamic json){
  return Status(
    json["id"] as int,
    json["account_id"] as int,
    json["type_post"] as String,
    json["post_id"] as int,
    json["type_status"] as String,
  );
}

Map<String,dynamic> _statusToJson(Status status){
  return <String,dynamic>{
    "id":status.id,
    "account_id":status.accountId,
    "type_post":status.typePost,
    "post_id":status.postId,
    "type_status":status.typeStatus,
  };
}