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
    Account("avatar1.jpg","Khang"),
    Account("avatar2.jpg","Trung"),
    Account("avatar3.jpg","Oanh"),
    Account("avatar4.jpg","Khangg"),
    Account("avatar5.jpg","Trungg"),
  ];
    List<Place> places = [
    Place("Nha Trang","Miền Trung", "Biển" , "Khám phá ngay trung tâm thành phố Nha Trang có gì chơi" , "place1.jpg"),
    Place("Thừa Thiên Huế","Miền Trung","Núi","phong cách đẹp" , "place2.jpg"),
    Place("Vịnh Hạ Long" , "Miền Bắc" , "Vịnh", "Phong cách đẹp" , "place3.jpg"),

  ];
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
                onPressed: (){},
                icon: const Icon(
                  Icons.thumb_up_alt,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.thumb_down_alt,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: (){},
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
