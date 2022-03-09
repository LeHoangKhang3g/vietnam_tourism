import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';

class SharePlace extends StatefulWidget{
  SharePlace({required this.place});
  Place place;
  @override 
  _StateSharePlace createState()=>_StateSharePlace();
}

class _StateSharePlace extends State<SharePlace>{
  File imageFile = File("");
  Image imageToShare=Image.asset("images/default/camera.jpg");
  TextEditingController _controller = TextEditingController();
  String imageName = "";

  @override 
  Widget build(BuildContext context){
    void share(){
      API(url: "http://127.0.0.1:8000/api/add-post-share")
      .postPostShare(Post(0, MyApp.accountUsed.id, widget.place.id, DateTime.now(), _controller.text, imageName),imageFile)
      .then((value){
        // final temp=json.decode(value.body);
        // if(temp["success"]){
        //   MyApp.repository.posts=(json.decode(temp["data"])  as List<dynamic> ).map((e) => Post.fromJson(e)).toList();
        //   showDialog(
        //     context: context, 
        //     builder: (BuildContext context)=>AlertDialog(
        //       title: const Text("Thông báo"),
        //       content: const Text("Share thành công!"),
        //       actions: [
        //         TextButton(
        //           onPressed: (){
        //             Navigator.pop(context,"Cancel");        
        //             Navigator.pop(context);
        //           },
        //           child: const Text("Ok"),
        //         ),
        //       ],
        //     ),
        //   );
        // }
        // else{
        //   print(temp["error"]);
        // }
        if(value){
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
      });
      setState(() {});
    }
    _getFromCamera() async {
      
      XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
          imageFile = File(pickedFile.path);
          imageName=pickedFile.name;
      }
      imageToShare=Image.file(imageFile);
      setState(() {});
      Navigator.pop(context);
    }

    _getFromGallery() async {
      XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
          imageFile = File(pickedFile.path);
          imageName=pickedFile.name;
      }
      imageToShare=Image.file(imageFile);
      setState(() {});
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(
        title:const Text("Share"),
      ),
      body: ListView(
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
          InkWell(
            onTap: (){
              showDialog(context: context, builder: (context)=>AlertDialog(
                content: const Text("Tải ảnh lên"),
                actions: [
                  TextButton(onPressed: (){_getFromCamera();}, child: const Text("Chụp ảnh")),
                  TextButton(onPressed: (){_getFromGallery();}, child: const Text("Tải từ Gallery")),
                  TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Huỷ")),
                ],
              ));
              setState(() {});
            },
            child: imageToShare,
          ),
          Row(
            children: [
              TextButton(
                onPressed: (){
                    share();  
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
          )
        ],
      ),
    );
  }                    
}
                       
