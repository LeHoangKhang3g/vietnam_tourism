import 'dart:convert';

import 'package:map_launcher/map_launcher.dart';
import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/comments/comment.dart';
import 'package:vietnam_tourism_flutter/login/login.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';
import 'package:vietnam_tourism_flutter/places/place_detail.dart';
import 'package:vietnam_tourism_flutter/time/time.dart';

class PostShare extends StatefulWidget {
  PostShare({Key ?key , required this.post }):super(key:key); 
   @override
  _PostShareState createState() => _PostShareState();
  Post post;

}

class _PostShareState extends State<PostShare>{
  bool like=false;
  bool unlike=false;
  bool likeBeforeSave=false;
  bool unlikeBeforeSave=false;
  int likes=0;
  int unlikes=0;
  Iterable<Status> status = [];
  bool isLoad=false;
  bool isSave=false;
  bool visibleComment = false;
  Iterable<Comment> comments = [];

  @override
  void initState(){
    super.initState();
    likes = MyApp.repository.lstStatus.where((element) => element.typePost=="post")
    .where((element) => element.postId==widget.post.id).where((element) => element.typeStatus=="like").toList().length;
    unlikes = MyApp.repository.lstStatus.where((element) => element.typePost=="post")
    .where((element) => element.postId==widget.post.id).where((element) => element.typeStatus=="unlike").toList().length;

  
    
    status = MyApp.repository.lstStatus.where((element) => element.accountId==MyApp.accountUsed.id).where((element) => element.typePost=="post")
    .where((element) => element.postId==widget.post.id).toList();

    like=false;
    unlike=false;
    status.forEach((element) {
      if(element.typeStatus=="like"){
        like=true;
      }
      else if(element.typeStatus=="unlike"){
        unlike=true;
      }                     
    });
    likeBeforeSave=like;
    unlikeBeforeSave=unlikeBeforeSave;
  }

  

  @override
  Widget build(BuildContext context){
    double width=MediaQuery.of(context).size.width;

    comments=MyApp.repository.comments.where((element) => element.typePost=="post")
    .where((element) => element.postId==widget.post.id).toList();

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


    Widget buildComment(Comment comment) => !visibleComment ?Container() :  Container(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(1),
          child: CircleAvatar(
            foregroundImage: NetworkImage(
              MyApp.repository.accounts.where((element) => element.id == comment.accountId).first.avatar,
            ),
          ),
        ),
        title: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MyApp.repository.accounts.where((account) => account.id==comment.accountId).first.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 Text(
                  SeeTime(comment.time).seeTime(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ), 
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(1),
              child: Text(
                comment.content,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,    
                  ),
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
      trailing: comment.accountId==MyApp.accountUsed.id? IconButton(icon: const Icon(Icons.delete),onPressed: (){
        API(url: "http://127.0.0.1:8000/api/delete-comment").deleteComment(comment).then((value){
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
        });
      },):Text(""),
      )
    );
    if(!isLoad&&!isSave){
      if(!MyApp.repository.statusIsUpdate){
        isLoad=true;
        API(url: "http://127.0.0.1:8000/api/status")
        .getDataString().then((value){
          final temp = json.decode(value);
          Iterable s = (temp as List<dynamic>).map((e) => Status.fromJson(e)).toList();
          MyApp.repository.lstStatus=s.cast<Status>();

          status = MyApp.repository.lstStatus.where((element) => element.accountId==MyApp.accountUsed.id).where((element) => element.typePost=="post")
          .where((element) => element.postId==widget.post.id).toList();

          likes = MyApp.repository.lstStatus.where((element) => element.typePost=="post")
          .where((element) => element.postId==widget.post.id).where((element) => element.typeStatus=="like").toList().length;

          unlikes = MyApp.repository.lstStatus.where((element) => element.typePost=="post")
          .where((element) => element.postId==widget.post.id).where((element) => element.typeStatus=="unlike").toList().length;

          isLoad=false;
          MyApp.repository.statusIsUpdate=true;
          setState(() {});
        });
      }
    }
    Future<void> goToXY(double x, double y, String title) async {
      final availableMaps = await MapLauncher.installedMaps;
      await availableMaps.first.showMarker(
        coords: Coords(x, y),
        title: title,
      );
    }
    if(!isLoad&&!isSave){
      if(likeBeforeSave!=like&&unlikeBeforeSave!=unlike){
        isSave=true;
        if(like){
          API(url: "http://127.0.0.1:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"post",widget.post.id,"like"), "true").then((value){
            likeBeforeSave=like;
            unlikeBeforeSave=unlike;  
            MyApp.repository.statusIsUpdate=false;   
            isSave=false;      
            setState(() {}); 
          });
        }
        else{
          API(url: "http://127.0.0.1:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"post",widget.post.id,"unlike"), "true").then((value){
            likeBeforeSave=like;
            unlikeBeforeSave=unlike;  
            MyApp.repository.statusIsUpdate=false;   
            isSave=false;      
            setState(() {});    
          });
        }
      }
      else if(likeBeforeSave!=like){
        isSave=true;
        if(like){
          API(url: "http://127.0.0.1:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"post",widget.post.id,"like"), "true").then((value){
            likeBeforeSave=like;              
            MyApp.repository.statusIsUpdate=false;
            isSave=false;   
            setState(() {}); 
          });
        }
        else{
          API(url: "http://127.0.0.1:8000/api/change-status")
          .postChangeStatus(status.where((element) => element.typeStatus=="like").first, "false").then((value){
            likeBeforeSave=like;
            MyApp.repository.statusIsUpdate=false;
            isSave=false;                
            setState(() {});  
          });
        }
      }
      else if(unlikeBeforeSave!=unlike){
        if(unlike){
          API(url: "http://127.0.0.1:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"post",widget.post.id,"unlike"), "true").then((value){
            unlikeBeforeSave=unlike;             
            MyApp.repository.statusIsUpdate=false; 
            isSave=false;          
            setState(() {});                 
          });
        }
        else{
          API(url: "http://127.0.0.1:8000/api/change-status")
          .postChangeStatus(status.where((element) => element.typeStatus=="unlike").first, "false").then((value){
            unlikeBeforeSave=unlike;
            MyApp.repository.statusIsUpdate=false;
            isSave=false;    
            setState(() {});    
          });
        }
      }
    }


    return Container(
      padding: const EdgeInsets.all(3),
      child: Card(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      child: CircleAvatar(
                        foregroundImage: NetworkImage(
                          MyApp.repository.accounts.where((account) => account.id==widget.post.accountId).first.avatar,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MyApp.repository.accounts.where((account) => account.id==widget.post.accountId).first.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            SeeTime(widget.post.time).seeTime(),
                            style:const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ), 
                    ),
                    const Text(
                      "Check in",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),   
                    Flexible(
                      child: TextButton(
                        onPressed: (){
                          final place =MyApp.repository.places.where((place) => place.id==widget.post.placeId).first;
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>PlaceDetail(place: place)));
                        }, 
                        child: Text(
                          MyApp.repository.places.where((place) => place.id==widget.post.placeId).first.name,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )          
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(1),
                child: Text(
                  widget.post.content,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                ),
              ),
              Image.network(
                widget.post.imageName,
                width: width,
                fit:BoxFit.cover,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      if(MyApp.accountUsed.id==0){
                        goToLogin();
                        return;
                      }
                      setState(() {
                        if(like){
                          like=false;
                          likes--;
                        }
                        else{
                          likes++;
                          like=true;
                          if(like==true&&unlike==true){
                            unlikes--;
                            unlike=false;
                          }   
                        }                        
                      });
                    },
                    icon: Icon(
                      Icons.thumb_up_alt,
                      color: like?Colors.green:Colors.grey,
                    ),
                  ),
                  Text(likes.toString()),
                  IconButton(
                    onPressed: (){
                      if(MyApp.accountUsed.id==0){
                        goToLogin();
                        return;
                      }
                      setState(() {
                        if(unlike){
                          unlikes--;
                          unlike=false;
                          
                        }
                        else{
                          unlikes++;
                          unlike=true;
                          if(like==true&&unlike==true){
                            likes--;
                            like=false;
                          }   
                        }                                         
                      });
                    },
                    icon: Icon(
                      Icons.thumb_down_alt,
                      color: unlike?Colors.red: Colors.grey,
                    ),
                  ),
                  Text(unlikes.toString()),
                  IconButton(
                    onPressed: (){
                      visibleComment = ! visibleComment;
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.comment,
                      color: comments.where((element) => element.accountId==MyApp.accountUsed.id).toList().isNotEmpty?Colors.green:Colors.grey,
                    ),
                  ),
                  Text(comments.length.toString())
                ],
              ),
              !visibleComment?Container():CommentPage(typePost: "post",id: widget.post.id),
              ...comments.map(buildComment).toList(),
            ],
          ),
        ),
      ),
    );
  }
}  
