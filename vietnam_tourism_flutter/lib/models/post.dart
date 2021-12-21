import 'package:vietnam_tourism_flutter/models/comment.dart';
class Post{ 
  int id=0;
  int ownerId=0;
  int placeId=0;
  DateTime time=DateTime.now();
  String imageName="";

  //Save accountId liked, disliked comment 
  List<int> likeds = [];
  List<int> dislikeds = [];

  List<Comment> comments = [];
 
  Post(this.id, this.ownerId, this.placeId, this.time, this.imageName);
}