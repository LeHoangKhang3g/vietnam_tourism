import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
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

  Future<bool> postPostShare(Post post, File image) async{
    // return http.post(
    //   Uri.parse(url),
    //   body: <String,dynamic>{
    //     "data":json.encode(post.toJson()),
    //     "action":"post",
    //   },
    // );
    var request = http.MultipartRequest("POST",Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("picture", image.path));
    request.fields.addAll(<String,String>{
      "data":json.encode(post.toJson()),
      "action":"post",
    });
    
    var response =await request.send();
    // String responseStr=await response.stream.bytesToString();
    // print(responseStr);
    return true;
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

  Future<http.Response> addComment(Comment comment) async {
    http.Response response=await http.post(
      Uri.parse(url),
      body: <String, dynamic>{
        "data": json.encode(comment.toJson()),
        "action":"post",
      }
    );
    //print(response.body);
    return response; 
  }
  Future<http.Response> deleteComment(Comment comment) async {
    http.Response response=await http.post(
      Uri.parse(url),
      body: <String, dynamic>{
        "data": json.encode(comment.toJson()),
        "action":"post",
      }
    );
    //print(response.body);
    return response; 
  }

  Future<bool> postSignUp(Account account, bool avatarChange, bool backgroundChange,File avatar, File background) async {
    // return http.post(
    //   Uri.parse(url),
    //   body: <String, dynamic>{
    //     "data": json.encode(account.toJson()),
    //     "action":"post",
    //   }
    // );
    var request = http.MultipartRequest("POST",Uri.parse(url));
    avatarChange?request.files.add(await http.MultipartFile.fromPath("avatar", avatar.path)):0;
    backgroundChange?request.files.add(await http.MultipartFile.fromPath("background", background.path)):0;
    request.fields.addAll(<String,String>{
      "data":json.encode(account.toJson()),
      "avatarChange":avatarChange.toString(),
      "backgroundChange":backgroundChange.toString(),
      "action":"post",
    });
    
    var response =await request.send();
    // String responseStr=await response.stream.bytesToString();
    // print(responseStr);
    return true;
  }

  Future<http.Response> updateProfile(Account account) async {
    return http.post(
      Uri.parse(url),
      body: <String, dynamic>{
        "data": json.encode(account.toJson()),
        "action":"post",
      }
    );
  }
  
}