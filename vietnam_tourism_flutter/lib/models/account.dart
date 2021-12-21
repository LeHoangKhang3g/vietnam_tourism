import 'package:vietnam_tourism_flutter/models/post.dart';
class Account {
  int id =0;
  String referenceId = "";
  String username ="";
  String password ="";
  String name="";
  DateTime? birthday;
  String email="";
  String imageName="";
  String background="";
  
  List<Post> posts = [];
    
  Account(this.imageName, this.name);
}