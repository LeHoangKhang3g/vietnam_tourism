import 'dart:math';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
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
    );
  }
}