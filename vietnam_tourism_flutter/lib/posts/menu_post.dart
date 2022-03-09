import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/cook.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';
import 'package:vietnam_tourism_flutter/models/stay.dart';
import 'package:vietnam_tourism_flutter/posts/post.dart';



class PostMenu extends StatefulWidget{
  PostMenu();
  @override
  _PostMenuState createState()=> _PostMenuState();
}
class _PostMenuState extends State<PostMenu>{
  Iterable<Post> posts=MyApp.repository.posts;

  @override
  Widget build(BuildContext context){
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

    return RefreshIndicator(
      child: ListView.builder(
      itemCount: posts.length,

      itemBuilder: (BuildContext context , index) {
        return PostShare(post: posts.elementAt(index));
      }, 
     
     ), 
      onRefresh: _pullRefresh
    );
    

 
  }
  
  Future<void> _pullRefresh() async {
    MyApp.repository.postIsUpdate=false;
    MyApp.repository.accountIsUpdate=false;
    MyApp.repository.placeIsUpdate=false;
    MyApp.repository.commentIsUpdate=false;
    MyApp.repository.statusIsUpdate=false;
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
    Iterable<Post> posts=MyApp.repository.posts;
    setState(() {});
  }
}
