import 'dart:convert';

import 'package:http/http.dart';
import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/login/login.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/repository/repository.dart';

class CommentPage extends StatefulWidget {
  CommentPage({required this.typePost, required this.id }); 
  String typePost;
  int id;
   @override
  _CommentState createState() => _CommentState();
  

}

class _CommentState extends State<CommentPage>{
  late TextEditingController _controller;
  bool isSendComment =false;
  bool isUpdateCommentPost=false;

  @override 
  void initState(){
    super.initState();
    _controller=TextEditingController();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  void _addComment(Comment comment) 
  {
    API(url: "http://127.0.0.1:8000/api/add-comment").addComment(comment)
    .then((value){
      dynamic temp = json.decode(value.body);   
      if(temp["success"])
      {
        MyApp.repository.comments=(json.decode(temp["data"])  as List<dynamic> ).map((e) => Comment.fromJson(e)).toList();
      }
      else
      {
        print(temp["error"]);
      }
      setState(() {});
      isSendComment=false;
    });
  }

  @override
  Widget build(BuildContext context){

    void goToLogin(){
      showDialog(context: context, builder: (BuildContext context)=>AlertDialog(
        title: const Text("Đăng nhập"),
        content: const Text("Đăng nhập để tiếp tục"),
        actions: [
          TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Lúc khác")),
          TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const Login()));
            }, 
            child: const Text("Đăng nhập"),
          )
        ],
      ));
    }
    
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: "viết bình luận ở đây...",
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 10.0),
        border:  OutlineInputBorder(
          borderRadius:  BorderRadius.circular(25.0),
        ),
        suffixIcon: OutlineButton(
          onPressed: () {
            if(MyApp.accountUsed.id==0){
              goToLogin();
              return;
            }
            if(!isSendComment && _controller.text!=""){
              isSendComment=true;
              _addComment(Comment(0, MyApp.accountUsed.id, widget.typePost, widget.id, _controller.text, DateTime.now()));
              MyApp.repository.commentIsUpdate=false;
              _controller.text="";
            }
            setState(() {});
          },
          borderSide: BorderSide.none,
          child: const Text(
            "Viết Bình luận",
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),     
        style: const TextStyle(color: Colors.black),
    );
          
  }
}