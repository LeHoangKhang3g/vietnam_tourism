import 'package:flutter/material.dart';

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
                      child: const CircleAvatar(
                        radius: 50,
                        foregroundImage: ExactAssetImage("images/avatar4.jpg"),
                      ),   
                    ),      
                    const Text("cdth19c@gmail.com"),
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
