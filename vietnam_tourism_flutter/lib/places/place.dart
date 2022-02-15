import 'dart:convert';

import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/comments/comment.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:vietnam_tourism_flutter/time/time.dart';


class PlacePost extends StatefulWidget {
  PlacePost({Key ?key , required this.place }):super(key:key); 
   @override
  _PlacePostState createState() => _PlacePostState();
  Place place;

}

class _PlacePostState extends State<PlacePost>{
  late TextEditingController _controller;
  bool like=false;
  bool unlike=false;
  bool likeBeforeSave=false;
  bool unlikeBeforeSave=false;
  int likes=0;
  int unlikes=0;
  Iterable<Status> status=[];
  bool isLoad=false;
  bool isSave=false;
  bool visibleComment = false;
  Iterable<Comment> comments = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _controller=TextEditingController();

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
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){

    comments=MyApp.repository.comments.where((element) => element.typePost=="place")
    .where((element) => element.postId==widget.place.id).toList();

    Widget buildComment(Comment comment) => !visibleComment ?Container() :  Container(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            child: CircleAvatar(
              foregroundImage: ExactAssetImage(
              "images/avatars/"+MyApp.repository.accounts.where((element) => element.id == comment.accountId).first.avatar,
              ),
            )
          ),
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
          SingleChildScrollView(
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
          )
        ],
      )
    );
    Future<void> goToXY(double x, double y, String title) async {
      final availableMaps = await MapLauncher.installedMaps;
      await availableMaps.first.showMarker(
        coords: Coords(x, y),
        title: title,
      );
    }
    void share(){
      API(url: "http://10.0.2.2:8000/api/add-post-share")
      .postPostShare(Post(0, MyApp.accountUsed.id, widget.place.id, DateTime.now(), _controller.text, widget.place.imageName))
      .then((value){
        final temp=json.decode(value.body);
        if(temp["success"]){
          MyApp.repository.posts=(json.decode(temp["data"])  as List<dynamic> ).map((e) => Post.fromJson(e)).toList();
          showDialog(
            context: context, 
            builder: (BuildContext context)=>AlertDialog(
              title: const Text("Thông báo"),
              content: const Text("Share thành công!"),
              actions: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(context,"Cancel");        
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"),
                ),
              ],
            ),
          );
        }
        else{
          print(temp["error"]);
        }
      });
      setState(() {});
    }
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
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"place",widget.place.id,"like"), "true").then((value){
            likeBeforeSave=like;
            unlikeBeforeSave=unlike;  
            MyApp.repository.statusIsUpdate=false;   
            isSave=false;      
            setState(() {}); 
          });
        }
        else{
          API(url: "http://10.0.2.2:8000/api/change-status")
          .postChangeStatus(Status(0,MyApp.accountUsed.id,"place",widget.place.id,"unlike"), "true").then((value){
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
                onPressed: (){
                  visibleComment=!visibleComment;
                  setState(() { });
                },
                icon: Icon(
                  Icons.comment,
                  color: comments.where((element) => element.accountId==MyApp.accountUsed.id).toList().isNotEmpty?Colors.green:Colors.grey,
                ),
              ),
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (BuildContext context)=>AlertDialog(
                      title: const Text("Chia sẻ bài viết"),
                      content: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: <Widget>[               
                              Container(
                                padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                                child: TextField(
                                      controller: _controller,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(),
                                        labelText: 'Nội dung chia sẻ',
                                      ),
                                  ),
                              ),
                              Image.asset(
                                "images/places/"+widget.place.imageName,
                                fit:BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: (){
                            if (_formKey.currentState?.validate() ?? false) {
                              share();
                            }       
                          },
                          child: const Text("Ok"),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context,"Cancel");        
                          },
                          child: const Text("Cancel"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: (){
                  final place =MyApp.repository.places.where((place) => place.id==widget.place.id).first;
                  goToXY(place.locationX,place.locationY,place.name);
                },
                icon: const Icon(
                  Icons.location_pin,
                  color: Colors.grey,
                ),
              ), 
            ],
          ),
          !visibleComment?Container():CommentPage(typePost: "place",id: widget.place.id),
          ...comments.map(buildComment).toList(),
        ],
      ),
      
    );
  }
}  
