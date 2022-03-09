import 'dart:convert';
import 'dart:io';

import 'package:bordered_text/bordered_text.dart';
import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/comments/comment.dart';
import 'package:vietnam_tourism_flutter/login/login.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:vietnam_tourism_flutter/places/place_detail.dart';
import 'package:vietnam_tourism_flutter/share/share_place.dart';
import 'package:vietnam_tourism_flutter/time/time.dart';
import 'package:image_picker/image_picker.dart';


class PlaceImage extends StatefulWidget {
  PlaceImage({Key ?key , required this.place }):super(key:key); 
   @override
  _PlaceImageState createState() => _PlaceImageState();
  Place place;

}

class _PlaceImageState extends State<PlaceImage>{
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  File imageFile = File("");

  @override
  void initState(){
    super.initState();
    _controller=TextEditingController();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){

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
  
    Future<void> goToXY(double x, double y, String title) async {
      final availableMaps = await MapLauncher.installedMaps;
      await availableMaps.first.showMarker(
        coords: Coords(x, y),
        title: title,
      );
    }
    
    return Container(
      margin: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>PlaceDetail(place: widget.place)));
                    },
                    splashColor: Colors.white,
                    child: Image.network(
                      widget.place.imageName,
                      fit: BoxFit.cover,
                      width: 600,
                      height: 210,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(1),
                    child: ListTile(
                      onTap: (){},
                      leading:  Container(
                          padding: const EdgeInsets.fromLTRB(10 ,0 , 10 , 0),
                          child:BorderedText(
                            child: Text(
                              widget.place.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ) ,
                        ),
                      title:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BorderedText(
                              strokeWidth: 4,
                              child: Text(
                                widget.place.area,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            BorderedText(
                              strokeWidth: 4,
                              child: Text(
                                widget.place.region,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ), 
                      
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 165),
                    child: Row(
                      children: [
                        FloatingActionButton(
                          onPressed: (){
                            if(MyApp.accountUsed.id==0){
                              goToLogin();
                              return;
                            }
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
                                        imageFile.path==""?
                                        Image.asset(
                                          "images/default/camera.jpg",
                                          fit:BoxFit.cover,
                                        ):
                                        Image.file(imageFile),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SharePlace(place: widget.place)));     
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
                          backgroundColor: Colors.white,
                          mini: true,
                          child: Icon(
                            Icons.share,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: (){
                            if(MyApp.accountUsed.id==0){
                              goToLogin();
                              return;
                            }
                            final place =MyApp.repository.places.where((place) => place.id==widget.place.id).first;
                            goToXY(place.locationX,place.locationY,place.name);
                          },
                          mini: true,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.blue.shade700,
                          ),
                        ), 
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          
       
      ),
    );
    
  }
}  
