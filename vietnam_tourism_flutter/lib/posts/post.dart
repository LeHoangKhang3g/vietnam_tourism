import 'dart:convert';

import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';

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

    if(!isLoad&&!isSave){
      if(!MyApp.repository.statusIsUpdate){
        isLoad=true;
        API(url: "http://10.0.2.2:8000/api/status")
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

    if(!isLoad&&!isSave){
      if(likeBeforeSave!=like&&unlikeBeforeSave!=unlike){
        isSave=true;
        if(like){
          API(url: "http://10.0.2.2:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"post",widget.post.id,"like"), "true").then((value){
            likeBeforeSave=like;
            unlikeBeforeSave=unlike;  
            MyApp.repository.statusIsUpdate=false;   
            isSave=false;      
            setState(() {}); 
          });
        }
        else{
          API(url: "http://10.0.2.2:8000/api/change-status")
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
          API(url: "http://10.0.2.2:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"post",widget.post.id,"like"), "true").then((value){
            print(value.body);
            likeBeforeSave=like;              
            MyApp.repository.statusIsUpdate=false;
            isSave=false;   
            setState(() {}); 
          });
        }
        else{
          API(url: "http://10.0.2.2:8000/api/change-status")
          .postChangeStatus(status.where((element) => element.typeStatus=="like").first, "false").then((value){
            print(value.body);
            likeBeforeSave=like;
            MyApp.repository.statusIsUpdate=false;
            isSave=false;                
            setState(() {});  
          });
        }
      }
      else if(unlikeBeforeSave!=unlike){
        if(unlike){
          API(url: "http://10.0.2.2:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"post",widget.post.id,"unlike"), "true").then((value){
            unlikeBeforeSave=unlike;             
            MyApp.repository.statusIsUpdate=false; 
            isSave=false;          
            setState(() {});                 
          });
        }
        else{
          API(url: "http://10.0.2.2:8000/api/change-status")
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
                    foregroundImage: ExactAssetImage(
                      "images/avatars/"+MyApp.repository.accounts.where((account) => account.id==widget.post.accountId).first.avatar,
                    ),
                  )
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
                      const Text(
                        "2 giờ trước",
                        style: TextStyle(
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
                TextButton(
                  onPressed: (){}, 
                  child: Text(
                    MyApp.repository.places.where((place) => place.id==widget.post.placeId).first.name,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
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
          Image.asset(
            "images/places/"+widget.post.imageName,
            width: width,
            fit:BoxFit.cover,
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
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
                  color: unlike?Colors.green: Colors.grey,
                ),
              ),
              Text(unlikes.toString()),
              IconButton(
                onPressed: (){
                  //showModalBottomSheet
                },
                icon: const Icon(
                  Icons.comment,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}  
