import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/login/login.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/repository/repository.dart';
import 'package:vietnam_tourism_flutter/screen.dart';
import 'places/place.dart';
import 'places/list_place.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static Account accountUsed=Account(0,"","","Ẩn danh",DateTime.now(),"","","anonymous.jpg","");
  static Repository repository = Repository();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainScreen(),
    );
  }
}

// if(!MyApp.repository.accountIsUpdate){
//       API(url: "http://127.0.0.1:8000/api/accounts")
//       .getDataString().then((value){
//         final temp = json.decode(value);
//         Iterable s = (temp as List<dynamic>).map((e) => Account.fromJson(e)).toList();
//         MyApp.repository.accounts=s.cast<Account>();
//         setState(() {});
//         MyApp.repository.accountIsUpdate=true;
//       });
//     }
//     if(!MyApp.repository.placeIsUpdate){
//       API(url: "http://127.0.0.1:8000/api/places")
//       .getDataString().then((value){
//         final temp = json.decode(value);
//         Iterable s = (temp as List<dynamic>).map((e) => Place.fromJson(e)).toList();
//         MyApp.repository.places=s.cast<Place>();
//         setState(() {});
//         MyApp.repository.placeIsUpdate=true;
//       });
//     }
//     if(!MyApp.repository.postIsUpdate){
//       API(url: "http://127.0.0.1:8000/api/posts")
//       .getDataString().then((value){
//         final temp = json.decode(value);
//         Iterable s = (temp as List<dynamic>).map((e) => Post.fromJson(e)).toList();
//         MyApp.repository.posts=s.cast<Post>();
//         setState(() {});
//         MyApp.repository.postIsUpdate=true;
//       });
//     }
//     if(!MyApp.repository.commentIsUpdate){
//       API(url: "http://127.0.0.1:8000/api/comments")
//       .getDataString().then((value){
//         final temp = json.decode(value);
//         Iterable s = (temp as List<dynamic>).map((e) => Comment.fromJson(e)).toList();
//         MyApp.repository.comments=s.cast<Comment>();
//         setState(() {});
//         MyApp.repository.commentIsUpdate=true;
//       });
//     }
//     if(!MyApp.repository.statusIsUpdate){
//       API(url: "http://127.0.0.1:8000/api/status")
//       .getDataString().then((value){
//         final temp = json.decode(value);
//         Iterable s = (temp as List<dynamic>).map((e) => Status.fromJson(e)).toList();
//         MyApp.repository.lstStatus=s.cast<Status>();
//         setState(() {});
//         MyApp.repository.statusIsUpdate=true;
//       });
//     }

