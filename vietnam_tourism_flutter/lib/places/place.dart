import 'dart:convert';

import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';

class PlacePost extends StatefulWidget {
  PlacePost({Key ?key , required this.place }):super(key:key); 
   @override
  _PlacePostState createState() => _PlacePostState();
  Place place;

}

class _PlacePostState extends State<PlacePost>{
  bool like=false;
  bool unlike=false;
  bool likeBeforeSave=false;
  bool unlikeBeforeSave=false;
  int likes=0;
  int unlikes=0;
  Iterable<Status> status=[];
  bool isLoad=false;
  bool isSave=false;

  @override
  void initState(){
    super.initState();

    likes = MyApp.repository.lstStatus.where((element) => element.typePost=="place")
    .where((element) => element.postId==widget.place.id).where((element) => element.typeStatus=="like").toList().length;
    unlikes = MyApp.repository.lstStatus.where((element) => element.typePost=="place")
    .where((element) => element.postId==widget.place.id).where((element) => element.typeStatus=="unlike").toList().length;

    status = MyApp.repository.lstStatus.where((element) => element.accountId==MyApp.accountUsed.id).where((element) => element.typePost=="place")
    .where((element) => element.postId==widget.place.id).toList();
    
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
    unlikeBeforeSave=unlike;
  }

  @override
  Widget build(BuildContext context){

    if(!isLoad&&!isSave){
      if(!MyApp.repository.statusIsUpdate){
        isLoad=true;
        API(url: "http://10.0.2.2:8000/api/status")
        .getDataString().then((value){
          final temp = json.decode(value);
          Iterable s = (temp as List<dynamic>).map((e) => Status.fromJson(e)).toList();
          MyApp.repository.lstStatus=s.cast<Status>();

          status = MyApp.repository.lstStatus.where((element) => element.accountId==MyApp.accountUsed.id).where((element) => element.typePost=="place")
          .where((element) => element.postId==widget.place.id).toList();

          likes = MyApp.repository.lstStatus.where((element) => element.typePost=="place")
          .where((element) => element.postId==widget.place.id).where((element) => element.typeStatus=="like").toList().length;

          unlikes = MyApp.repository.lstStatus.where((element) => element.typePost=="place")
          .where((element) => element.postId==widget.place.id).where((element) => element.typeStatus=="unlike").toList().length;

          setState(() {});     
          isLoad=false;   
          MyApp.repository.statusIsUpdate=true;
        });
      }
    }
    
    if(!isLoad&&!isSave){
      if(likeBeforeSave!=like&&unlikeBeforeSave!=unlike){
        isSave=true;
        if(like){
          API(url: "http://10.0.2.2:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"place",widget.place.id,"like"), "double").then((value){
            likeBeforeSave=like;
            unlikeBeforeSave=unlike;  
            MyApp.repository.statusIsUpdate=false;   
            isSave=false;      
            setState(() {}); 
          });
        }
        else{
          API(url: "http://10.0.2.2:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"place",widget.place.id,"unlike"), "double").then((value){
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
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"place",widget.place.id,"like"), "true").then((value){
            likeBeforeSave=like;              
            MyApp.repository.statusIsUpdate=false;
            isSave=false;   
            setState(() {}); 
          });
        }
        else{
          API(url: "http://10.0.2.2:8000/api/change-status")
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
          API(url: "http://10.0.2.2:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"place",widget.place.id,"unlike"), "true").then((value){
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
      color: const Color.fromRGBO(255, 255, 255, 100),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10 ,0 , 10 , 0),
                  child:  Text(
                    widget.place.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.place.area,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      widget.place.region,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ), 
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1),
            child: Text( 
              widget.place.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Image.asset(
            "images/places/"+widget.place.imageName,
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
                onPressed: (){},
                icon: const Icon(
                  Icons.comment,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.share,
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
