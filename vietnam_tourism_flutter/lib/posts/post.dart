import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';
import 'package:vietnam_tourism_flutter/models/post.dart';

class PostShare extends StatefulWidget {
  PostShare({Key ?key , required this.post }):super(key:key); 
   @override
  _PostShareState createState() => _PostShareState();
  Post post;
  List<Account> accounts =[
    Account(1,"khang1","pass1","Khang",DateTime(2001,5,4),"khang1@gmail.com","avatar1.jpg","Background1.jpg",[]),
    Account(2,"trung2","pass2","Trung",DateTime(2001,5,5),"trung2@gmail.com","avatar2.jpg","Background1.jpg",[]),
    Account(3,"oanh3","pass3","Oanh",DateTime(2001,5,6),"oanh3@gmail.com","avatar3.jpg","Background1.jpg",[]),
    Account(4,"khang4","pass4","Hoàng Khang",DateTime(2001,5,7),"khang4@gmail.com","avatar4.jpg","Background1.jpg",[]),
    Account(5,"trung5","pass5","Trungg",DateTime(2001,5,8),"trung5@gmail.com","avatar5.jpg","Background1.jpg",[]),
  ];
    List<Place> places = [
    Place(1,"Nha Trang","Miền Trung", "Khu Vực Trung Bộ" , "Khám phá ngay trung tâm thành phố Nha Trang có gì chơi:  " , "place1.jpg",[],[],[],[]),
    Place(2,"Thừa Thiên Huế","Miền Trung","Khu Vực Trung Bộ","kiến trúc thời phong kiến , phong cảnh phong tục văn hóa dân tộc việt nam" , "place2.jpg",[],[],[],[]),
    Place(3,"Vịnh Hạ Long" , "Miền Bắc" , "Khu Vực Bắc Bộ", "Có Nhiều bãi đẹp , phong phú về địa hình , các hòn đảo , đá san hô" , "place3.jpg",[],[],[],[]),
  ];

  bool like = false;
  bool unlike=false;
}

class _PostShareState extends State<PostShare>{
  @override
  Widget build(BuildContext context){
    double width=MediaQuery.of(context).size.width;
    return Container(
      color: const Color.fromRGBO(255, 255, 255, 100),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(1),
                  child: CircleAvatar(
                    foregroundImage: ExactAssetImage(
                      "images/"+widget.accounts[widget.post.ownerId].imageName,
                    ),
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.accounts[widget.post.ownerId].name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "2 giờ trước",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ), 
                ),
                const Text(
                  "Đang du lịch tại ",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),   
                Text(
                  widget.places[widget.post.placeId].name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),              
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1),
            child: Text(
              widget.post.content,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
            ),
          ),
          Image.asset(
            "images/"+widget.post.imageName,
            width: width,
            fit:BoxFit.cover,
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
                  setState(() {
                    widget.like = widget.like?false:true;
                    if(widget.like==true&&widget.unlike==true)
                      widget.unlike=false;
                  });
                },
                icon: Icon(
                  Icons.thumb_up_alt,
                  color: widget.like?Colors.blue:Colors.grey,
                ),
              ),
              IconButton(
                onPressed: (){
                  setState(() {
                    widget.unlike = widget.unlike?false:true;
                    if(widget.like==true&&widget.unlike==true)
                      widget.like=false;                    
                  });
                },
                icon: Icon(
                  Icons.thumb_down_alt,
                  color: widget.unlike?Colors.blue: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: (){
                  //showModalBottomSheet
                },
                icon: const Icon(
                  Icons.comment,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}  
