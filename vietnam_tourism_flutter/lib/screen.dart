import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/login/login.dart';
import 'package:vietnam_tourism_flutter/main.dart';


import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/cook.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';
import 'package:vietnam_tourism_flutter/models/stay.dart';
import 'package:vietnam_tourism_flutter/places/list_place_find.dart';
import 'package:vietnam_tourism_flutter/posts/menu_post.dart';

import 'profile/profile.dart';
import 'posts/list_post.dart';
import 'places/list_place.dart';

class MenuItem{
  final int id;
  final IconData icon;
  final String title;
  MenuItem(this.id,this.icon,this.title);
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<MenuItem> menu =[
    MenuItem(0,Icons.person_pin_rounded,"Profile"),
    MenuItem(1,Icons.logout,"Sign out"),
    MenuItem(2,Icons.login,"Sign in"),
    MenuItem(3,Icons.exit_to_app_sharp, "Exit")
  ];

  @override
  Widget build(BuildContext context) {
    if(!MyApp.repository.accountIsUpdate){
      API(url: "http://127.0.0.1:8000/api/accounts")
      .getDataString().then((value){
        final temp = json.decode(value);
        Iterable s = (temp as List<dynamic>).map((e) => Account.fromJson(e)).toList();
        MyApp.repository.accounts=s.cast<Account>();
        setState(() {});
        MyApp.repository.accountIsUpdate=true;
      });
    }
    if(!MyApp.repository.placeIsUpdate){
      API(url: "http://127.0.0.1:8000/api/places")
      .getDataString().then((value){
        final temp = json.decode(value);
        Iterable s = (temp as List<dynamic>).map((e) => Place.fromJson(e)).toList();
        MyApp.repository.places=s.cast<Place>();
        setState(() {});
        MyApp.repository.placeIsUpdate=true;
      });
    }
    if(!MyApp.repository.postIsUpdate){
      API(url: "http://127.0.0.1:8000/api/posts")
      .getDataString().then((value){
        final temp = json.decode(value);
        Iterable s = (temp as List<dynamic>).map((e) => Post.fromJson(e)).toList();
        MyApp.repository.posts=s.cast<Post>();
        setState(() {});
        MyApp.repository.postIsUpdate=true;
      });
    }
    if(!MyApp.repository.commentIsUpdate){
      API(url: "http://127.0.0.1:8000/api/comments")
      .getDataString().then((value){
        final temp = json.decode(value);
        Iterable s = (temp as List<dynamic>).map((e) => Comment.fromJson(e)).toList();
        MyApp.repository.comments=s.cast<Comment>();
        setState(() {});
        MyApp.repository.commentIsUpdate=true;
      });
    }
    if(!MyApp.repository.statusIsUpdate){
      API(url: "http://127.0.0.1:8000/api/status")
      .getDataString().then((value){
        final temp = json.decode(value);
        Iterable s = (temp as List<dynamic>).map((e) => Status.fromJson(e)).toList();
        MyApp.repository.lstStatus=s.cast<Status>();
        setState(() {});
        MyApp.repository.statusIsUpdate=true;
      });
    }
    if(!MyApp.repository.cookIsUpdate){
      API(url: "http://127.0.0.1:8000/api/cooks")
      .getDataString().then((value){
        final temp = json.decode(value);
        Iterable s = (temp as List<dynamic>).map((e) => Cook.fromJson(e)).toList();
        MyApp.repository.cooks=s.cast<Cook>();
        setState(() {});
        MyApp.repository.cookIsUpdate=true;
      });
    }
    if(!MyApp.repository.stayIsUpdate){
      API(url: "http://127.0.0.1:8000/api/stays")
      .getDataString().then((value){
        final temp = json.decode(value);
        Iterable s = (temp as List<dynamic>).map((e) => Stay.fromJson(e)).toList();
        MyApp.repository.stays=s.cast<Stay>();
        setState(() {});
        MyApp.repository.stayIsUpdate=true;
      });
    }
    Widget buildMenuItem(MenuItem item){
      if(((item.id==1||item.id==0)&&MyApp.accountUsed.id==0)||item.id==2&&MyApp.accountUsed.id!=0){
        return Container();
      }
      return ListTile(
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: (){
          if(item.id==0){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
            MyApp.repository.postIsUpdate=false;
            MyApp.repository.accountIsUpdate=false;
            MyApp.repository.placeIsUpdate=false;
            MyApp.repository.commentIsUpdate=false;
            MyApp.repository.statusIsUpdate=false;
          }
          else if(item.id==1){
            MyApp.repository.postIsUpdate=false;
            MyApp.repository.accountIsUpdate=false;
            MyApp.repository.placeIsUpdate=false;
            MyApp.repository.commentIsUpdate=false;
            MyApp.repository.statusIsUpdate=false;

            Navigator.pop(context);
            Navigator.pop(context);
            MyApp.accountUsed=Account(0,"","","",DateTime.now(),"","","","");
          }
          else if(item.id==2){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const Login()));
          }
          else if(item.id==3){
            exit(0);
          }
        },
      );
    }
    

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.blue.shade400,
        appBar: AppBar(
          flexibleSpace: Container(

          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.list),),
              Tab(icon: Icon(Icons.search)),
            ],
          ),
          title: const Text(
            'Du lịch',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                height: 160,
                padding: const EdgeInsets.all(1),
                child: Column(
                  children:[
                    Container(
                      padding: const EdgeInsets.all(14),
                      child: CircleAvatar(
                        radius: 50,
                        foregroundImage: NetworkImage(MyApp.accountUsed.avatar),
                      ),   
                    ),      
                    Text(MyApp.accountUsed.email),
                  ],
                ),
              ),
              ...menu.map(buildMenuItem).toList(),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PlaceScreen(),
            PostMenu(),
            PlaceFindScreen(),
          ],
        ),
      ),
    );
  }
}
