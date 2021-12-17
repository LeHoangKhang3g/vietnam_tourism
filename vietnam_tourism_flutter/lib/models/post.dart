import 'package:vietnam_tourism_flutter/models/comment.dart';
class Post{ 
  int id=0;
  int ownerId=0;
  String name="";
  String area="";   //miền 
  String region=""; //khu vực
  String description=""; //Mô tả
  String imageName="";

  //Save accountId liked, disliked comment 
  List<int> likeds = [];
  List<int> dislikeds = [];

  List<Comment> comments = [];
 

}