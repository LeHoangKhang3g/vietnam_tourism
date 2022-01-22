import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/comment.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';
import 'package:vietnam_tourism_flutter/models/status.dart';

class Repository{
  Iterable<Post> posts = [
    // Post(1,0,0,DateTime.now(),"Có nhiều bãi biển đẹp","place1.jpg",[],[],[]),
    // Post(2,1,1,DateTime.now(),"Cổ kính, hoài niệm","place2.jpg",[],[],[]),
    // Post(3,2,2,DateTime.now(),"Nước biển trong xanh, cảnh đẹp.","place3.jpg",[],[],[]),
  ];
  Iterable<Account> accounts =[
    // Account(1,"khang1","pass1","Khang",DateTime(2001,5,4),"khang1@gmail.com","avatar1.jpg","Background1.jpg",[]),
    // Account(2,"trung2","pass2","Trung",DateTime(2001,5,5),"trung2@gmail.com","avatar2.jpg","Background1.jpg",[]),
    // Account(3,"oanh3","pass3","Oanh",DateTime(2001,5,6),"oanh3@gmail.com","avatar3.jpg","Background1.jpg",[]),
    // Account(4,"khang4","pass4","Hoàng Khang",DateTime(2001,5,7),"khang4@gmail.com","avatar4.jpg","Background1.jpg",[]),
    // Account(5,"trung5","pass5","Trungg",DateTime(2001,5,8),"trung5@gmail.com","avatar5.jpg","Background1.jpg",[]),
  ];
  Iterable<Place> places = [
    // Place(1,"Nha Trang","Miền Trung", "Khu Vực Trung Bộ" , "Khám phá ngay trung tâm thành phố Nha Trang có gì chơi:  " , "place1.jpg",[],[],[],[]),
    // Place(2,"Thừa Thiên Huế","Miền Trung","Khu Vực Trung Bộ","kiến trúc thời phong kiến , phong cảnh phong tục văn hóa dân tộc việt nam" , "place2.jpg",[],[],[],[]),
    // Place(3,"Vịnh Hạ Long" , "Miền Bắc" , "Khu Vực Bắc Bộ", "Có Nhiều bãi đẹp , phong phú về địa hình , các hòn đảo , đá san hô" , "place3.jpg",[],[],[],[]),
  ];
  Iterable<Comment> comments=[];
  Iterable<Status> lstStatus=[];
  
  bool postIsUpdate=false;
  bool accountIsUpdate=false;
  bool placeIsUpdate=false;
  bool commentIsUpdate=false;
  bool statusIsUpdate=false;
}