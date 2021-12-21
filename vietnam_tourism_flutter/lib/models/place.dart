import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
class Place{
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

  Place(String s, String t, String u, String v, String w);

}