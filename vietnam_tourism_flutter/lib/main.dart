import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/login/login.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/repository/repository.dart';
import 'places/place.dart';
import 'places/list_place.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static Account accountUsed=Account(0,"","","",DateTime.now(),"","","");
  static Repository repository = Repository();
  static String searchKeyword="";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Login(),
    );
  }
}

