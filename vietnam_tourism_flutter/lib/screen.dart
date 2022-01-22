import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/main.dart';


import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';

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
    MenuItem(1,Icons.door_back_door_outlined,"Sign out"),
  ];
  TextEditingController controler = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Widget buildMenuItem(MenuItem item)=>ListTile(
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: (){
        if(item.id==0){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
        }
        else if(item.id==1){
          MyApp.repository.postIsUpdate=false;
          MyApp.repository.accountIsUpdate=false;
          MyApp.repository.placeIsUpdate=false;
          MyApp.repository.commentIsUpdate=false;
          MyApp.repository.statusIsUpdate=false;

          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(230, 230, 230, 100),
        appBar: AppBar(
          flexibleSpace: Container(
            height: 40,
            margin: const EdgeInsets.only(top: 10, left: 160, right: 20),
            child: TextField(
              controller: controler,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(40))),
                  hintStyle: TextStyle(color: Colors.black38),
                  hintText: "Search"),
            )),
            
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.people)),
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
                  color: Colors.blue,
                ),
                height: 160,
                padding: const EdgeInsets.all(1),
                child: Column(
                  children:[
                    Container(
                      padding: const EdgeInsets.all(14),
                      child: CircleAvatar(
                        radius: 50,
                        foregroundImage: ExactAssetImage("images/avatars/"+MyApp.accountUsed.avatar),
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
        body: const TabBarView(
          children: [
            PostScreen(),
            PlaceScreen(),
          ],
        ),
      ),
    );
  }
}
