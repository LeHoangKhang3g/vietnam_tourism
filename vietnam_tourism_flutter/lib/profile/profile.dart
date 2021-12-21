import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  const Profile({Key?key}):super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile>{
  
  
  @override 
  Widget build(BuildContext context){
    double widthScreen=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset(
                "images/Background1.jpg",
                fit: BoxFit.cover,
                width: widthScreen,
                height: 250,
              ),
              Container(
                margin: const EdgeInsets.only(top: 175),
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
                    CircleAvatar(
                      foregroundImage: ExactAssetImage("images/avatar4.jpg"),
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
            child: const Text(
              "Hoàng Khang",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),  
          ),
          Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const[
                Text(
                  "Ngày sinh: 4/5/2001",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Email: khangxyz3g@gmail.com",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}