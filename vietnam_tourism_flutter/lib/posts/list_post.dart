import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/posts/post.dart';



class PostScreen extends StatefulWidget{
  const PostScreen({Key?key}):super(key: key);
  @override
  _PostScreenState createState()=> _PostScreenState();
}
class _PostScreenState extends State<PostScreen>{
  List<Post> posts = [
    Post(1,0,0,"Có nhiều bãi biển đẹp","place1.jpg"),
    Post(2,1,1,"Cổ kính, hoài niệm","place2.jpg"),
    Post(3,2,2,"Nước biển trong xanh, cảnh đẹp.","place3.jpg"),
  ];

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: posts.length,

      itemBuilder: (BuildContext context , index) {
        return PostShare(post: posts[index]);
      }, 
     
     );
     
  }
}


