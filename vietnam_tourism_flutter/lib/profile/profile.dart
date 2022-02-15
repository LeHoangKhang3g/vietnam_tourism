import 'dart:convert';
import 'dart:math';

import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';

import '../posts/post.dart';
import '../models/post.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget{
  const Profile({Key?key}):super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile>{

  @override
  void initState(){
    super.initState();
    MyApp.accountUsed.posts=MyApp.repository.posts.where((element) => element.accountId==MyApp.accountUsed.id).toList();
  }

  @override 
  Widget build(BuildContext context){
    double widthScreen=MediaQuery.of(context).size.width;
    // Image image = Image.network(
    //   "http://127.0.0.1:8000/images/backgrounds/background"+MyApp.accountUsed.id.toString()+".jpg",
    //   fit: BoxFit.cover,
    //   width: widthScreen,
    //   height: 250,
    // );
    Future<void> _pullRefresh() async {
      MyApp.repository.postIsUpdate=false;
      MyApp.repository.accountIsUpdate=false;
      MyApp.repository.placeIsUpdate=false;
      MyApp.repository.commentIsUpdate=false;
      MyApp.repository.statusIsUpdate=false;
      if(!MyApp.repository.accountIsUpdate){
        API(url: "http://10.0.2.2:8000/api/accounts")
        .getDataString().then((value){
          final temp = json.decode(value);
          Iterable s = (temp as List<dynamic>).map((e) => Account.fromJson(e)).toList();
          MyApp.repository.accounts=s.cast<Account>();
          setState(() {});
          MyApp.repository.accountIsUpdate=true;
        });
      }
      if(!MyApp.repository.placeIsUpdate){
        API(url: "http://10.0.2.2:8000/api/places")
        .getDataString().then((value){
          final temp = json.decode(value);
          Iterable s = (temp as List<dynamic>).map((e) => Place.fromJson(e)).toList();
          MyApp.repository.places=s.cast<Place>();
          setState(() {});
          MyApp.repository.placeIsUpdate=true;
        });
      }
      if(!MyApp.repository.postIsUpdate){
        API(url: "http://10.0.2.2:8000/api/posts")
        .getDataString().then((value){
          final temp = json.decode(value);
          Iterable s = (temp as List<dynamic>).map((e) => Post.fromJson(e)).toList();
          MyApp.repository.posts=s.cast<Post>();
          setState(() {});
          MyApp.repository.postIsUpdate=true;
        });
      }
      if(!MyApp.repository.commentIsUpdate){
        API(url: "http://10.0.2.2:8000/api/comments")
        .getDataString().then((value){
          final temp = json.decode(value);
          Iterable s = (temp as List<dynamic>).map((e) => Comment.fromJson(e)).toList();
          MyApp.repository.comments=s.cast<Comment>();
          setState(() {});
          MyApp.repository.commentIsUpdate=true;
        });
      }
      if(!MyApp.repository.statusIsUpdate){
        API(url: "http://10.0.2.2:8000/api/status")
        .getDataString().then((value){
          final temp = json.decode(value);
          Iterable s = (temp as List<dynamic>).map((e) => Status.fromJson(e)).toList();
          MyApp.repository.lstStatus=s.cast<Status>();
          setState(() {});
          MyApp.repository.statusIsUpdate=true;
        });
      }
      setState(() {});
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body:  RefreshIndicator(
        child: ListView(
          children: [
            Stack(
              children: [
                Image.asset(
                  "images/backgrounds/"+MyApp.accountUsed.background,
                  fit: BoxFit.cover,
                  width: widthScreen,
                  height: 250,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 175),
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      CircleAvatar(
                        foregroundImage: ExactAssetImage("images/avatars/"+MyApp.accountUsed.avatar),
                        maxRadius: 75,
                      ),   
                    ],
                  )
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                MyApp.accountUsed.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),  
            ),
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    "Ngày sinh: "+MyApp.accountUsed.birthday.day.toString()+"/"+MyApp.accountUsed.birthday.month.toString()+"/"+MyApp.accountUsed.birthday.year.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Email: "+MyApp.accountUsed.email,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
            ...MyApp.accountUsed.posts.map((post) => PostShare(post: post)),
          ],
        ),
        onRefresh: _pullRefresh,
      )
      
    );
  }
}