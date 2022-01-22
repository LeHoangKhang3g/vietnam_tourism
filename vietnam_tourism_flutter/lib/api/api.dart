import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';

class API{
  API({required this.url});
  String url;
  Future<String> getDataString() async{
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return response.body;
    }
    else{
      throw Exception("Call Api failed");
    }
  }


  Future<http.Response> postSignIn(String username, String password) async{
    return http.post(
      Uri.parse(url),
      body: <String,dynamic>{
        "data":json.encode(<String,dynamic>{
          "username":username,
          "password":password,
        }),
        "action":"post",
      },
    );
  }

  Future<http.Response> postChangeStatus(Status status, String check) async{
    return http.post(
      Uri.parse(url),
      body: <String,dynamic>{
        "data":json.encode(status.toJson()),
        "check":check,
      }
    );
  }

  Future<http.Response> postPostShare(Post post) async{
    return http.post(
      Uri.parse(url),
      body: <String,dynamic>{
        "data":json.encode(post.toJson()),
        "action":"post",
      },
    );
  }

  Future<http.Response> postStatus(int accountId, String typePost, int postId, String typeStatus, bool set) async{
    return http.post(
      Uri.parse(url),
      body: <String,dynamic>{
        "data":json.encode(<String,dynamic>{
          "account_id":accountId,
          "type_post":typePost,
          "post_id":postId,
          "type_status":typeStatus,
        }),
        "action":"post",
        "message":set,
      },
    );
  }
  
}