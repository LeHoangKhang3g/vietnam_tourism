import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/api/api.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';

class CommentScreen extends StatefulWidget{
  const CommentScreen({Key?key}):super(key: key);
  @override
  _CommentScreenState createState()=> _CommentScreenState();
}
class _CommentScreenState extends State<CommentScreen>{

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
    return Container(
      
     
     );
  }
}