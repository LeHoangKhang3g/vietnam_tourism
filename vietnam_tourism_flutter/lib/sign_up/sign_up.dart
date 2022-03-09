import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import '../screen.dart';
import 'package:intl/intl.dart';



class SignUp extends StatefulWidget{
  const SignUp({Key ? key}) : super (key: key);
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;
  late TextEditingController _controller6;
  late TextEditingController dateController;
  DateTime birthday= DateTime.now().add(const Duration(days: -1));
  File backgroundFile = File("");
  File avatarFile = File("");
  Image backgroundImage=Image.network("http://127.0.0.1:8000/images/default/camera.jpg",height: 165,width: 300,);
  Image avatarImage=Image.network("http://127.0.0.1:8000/images/avatars/anonymous.jpg",height: 300,width: 300,);
  bool avatarChange=false;
  bool backgoundChange=false;

  @override
  void initState(){
    super.initState();
    _controller1=TextEditingController();
    _controller2=TextEditingController();
    _controller3=TextEditingController();
    _controller4=TextEditingController();
    _controller5=TextEditingController();
    _controller6=TextEditingController();
    dateController=TextEditingController();
  }

  @override
  void dispose(){
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    dateController.dispose();
    super.dispose();
  }

    _getFromCamera(String type) async {
      
      XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        if(type=="avatar"){
          avatarFile= File(pickedFile.path);
          avatarImage=Image.file(avatarFile);
          avatarChange=true;
        }   
        else if(type=="background"){
          backgroundFile= File(pickedFile.path);
          backgroundImage=Image.file(backgroundFile);
          backgoundChange=true;
        }
      }
      setState(() {});
      Navigator.pop(context);
    }

    _getFromGallery(String type) async {
      XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
          if(type=="avatar"){
          avatarFile= File(pickedFile.path);
          avatarImage=Image.file(avatarFile);
          avatarChange=true;
        }   
        else if(type=="background"){
          backgroundFile= File(pickedFile.path);
          backgroundImage=Image.file(backgroundFile);
          backgoundChange=true;
        }
      }
      setState(() {});
      Navigator.pop(context);
    }

  void signUp(){
    API(url: "http://127.0.0.1:8000/api/sign-up")
    .postSignUp(Account(0, _controller1.text, _controller2.text, _controller4.text, birthday, _controller5.text, _controller6.text, "http://127.0.0.1:8000/images/avatars/anonymous.jpg", "http://127.0.0.1:8000/images/avatars/background1.jpg")
    ,avatarChange,backgoundChange,avatarFile,backgroundFile)
    .then((value){
      // final temp=json.decode(value.body);
      // if(temp["success"]){
      //   showDialog(
      //     context: context, 
      //     builder: (BuildContext context)=>AlertDialog(
      //       title: const Text("Thông báo"),
      //       content: const Text("Đăng kí thành công!"),
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
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpFailed()));
      // }
      if(value){
        showDialog(
          context: context, 
          builder: (BuildContext context)=>AlertDialog(
            title: const Text("Thông báo"),
            content: const Text("Đăng kí thành công!"),
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
    }
    );
    setState(() {});
  }

  void _pickDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 30)))
    .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          if(pickedDate.isAfter(DateTime.now())||(pickedDate.day==DateTime.now().day
          &&pickedDate.month==DateTime.now().month&&pickedDate.year==DateTime.now().year)){
            showDialog(
              context: context, 
              builder: (BuildContext context)=>AlertDialog(
                title: const Text("Thông báo"),
                content: const Text("Ngày sinh không thể lớn hơn hoặc bằng ngày hiện tại!"),
                actions: [
                  TextButton(
                    onPressed: ()=>Navigator.pop(context,"Cancel"),
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );
          }
          else{
            dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            birthday=pickedDate;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body:  ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: Ink(
                width: 300,
                height: 150,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: const Icon(
                Icons.public,
                  color: Colors.green,
                  size: 90,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: const  Text(
              "SignUp",
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
          ),    
          Container(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextField(
                  controller: _controller1,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Username',
                  ),
              ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextField(
                  controller: _controller2,
                  obscureText: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Password',
                  ),
              ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextField(
                  controller: _controller3,
                  obscureText: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
              ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextField(
                  controller: _controller4,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
              ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              readOnly: true,
              enabled: true,
              validator:(value) {
                if (value == null || value.isEmpty) {
                  return 'Enter the birthday';
                }
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: 'Birthday',
              ),
              controller: dateController,
              onTap: () {
                _pickDate(context);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextField(
                  controller: _controller5,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),
              ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextField(
                  controller: _controller6,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
              ),
          ),
          InkWell(
            onTap: (){
              showDialog(context: context, builder: (context)=>AlertDialog(
                content: const Text("Tải ảnh lên"),
                actions: [
                  TextButton(onPressed: (){_getFromCamera("avatar");}, child: const Text("Chụp ảnh")),
                  TextButton(onPressed: (){_getFromGallery("avatar");}, child: const Text("Tải từ Gallery")),
                  TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Huỷ")),
                ],
              ));
              setState(() {});
            },
            child: avatarImage,
          ),
          InkWell(
            onTap: (){
              showDialog(context: context, builder: (context)=>AlertDialog(
                content: const Text("Tải ảnh lên"),
                actions: [
                  TextButton(onPressed: (){_getFromCamera("background");}, child: const Text("Chụp ảnh")),
                  TextButton(onPressed: (){_getFromGallery("background");}, child: const Text("Tải từ Gallery")),
                  TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Huỷ")),
                ],
              ));
              setState(() {});
            },
            child: backgroundImage,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child:  OutlinedButton( 
              onPressed: () {
                if(_controller2.text!=_controller3.text){
                  showDialog(
                    context: context, 
                    builder: (BuildContext context)=>AlertDialog(
                      title: const Text("Thông báo"),
                      content: const Text("Password phải trùng khớp với nhau!"),
                      actions: [
                        TextButton(
                          onPressed: ()=>Navigator.pop(context,"Cancel"),
                          child: const Text("Ok"),
                        ),
                      ],
                    ),
                  );
                }
                else if(_controller1.text.isEmpty||_controller2.text.isEmpty||_controller3.text.isEmpty||_controller4.text.isEmpty||_controller5.text.isEmpty||_controller6.text.isEmpty){
                  showDialog(
                    context: context, 
                    builder: (BuildContext context)=>AlertDialog(
                      title: const Text("Thông báo"),
                      content: const Text("Chưa nhập thông tin!"),
                      actions: [
                        TextButton(
                          onPressed: ()=>Navigator.pop(context,"Cancel"),
                          child: const Text("Ok"),
                        ),
                      ],
                    ),
                  );
                }
                else if(_controller4.text.isEmpty){
                  showDialog(
                    context: context, 
                    builder: (BuildContext context)=>AlertDialog(
                      title: const Text("Thông báo"),
                      content: const Text("Chưa nhập thông tin!"),
                      actions: [
                        TextButton(
                          onPressed: ()=>Navigator.pop(context,"Cancel"),
                          child: const Text("Ok"),
                        ),
                      ],
                    ),
                  );
                }
                else{
                  signUp();
                }
                setState(() {});
              },
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                ),
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.resolveWith((states) => Colors.black),
                fixedSize: MaterialStateProperty.resolveWith((states) => const Size(1500,50)), 
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child:  OutlinedButton( 
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                ),
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.resolveWith((states) => Colors.black),
                fixedSize: MaterialStateProperty.resolveWith((states) => const Size(1500,50)), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpFailed extends StatefulWidget{
    const SignUpFailed({Key ? key}) : super (key: key);
    @override
    _SignUpFailedState createState() => _SignUpFailedState();
  }
  class _SignUpFailedState extends State<SignUpFailed> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.green,
        body:  Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 100, bottom: 50),
            child: Center(
              child: Ink(
                width: 300,
                height: 150,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: const Icon(
                Icons.public_off,
                  color: Colors.green,
                  size: 90,
                ),
              ),
            ),
          ),
          const  Text(
            "UPS... conuldn't Sign Up",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
         const Text("Check your connection!"),
         const Text("Please,Try again."),
          Container(
           padding: const EdgeInsets.fromLTRB(50, 150, 50, 50),
           child:  OutlinedButton( 
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'TRY AGAIN',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
                style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.resolveWith((states) => Colors.black),
                  fixedSize: MaterialStateProperty.resolveWith((states) => const Size(1500,50)), 
                ),
            ),
            ),
        ],
      ),
    );
  }
}
