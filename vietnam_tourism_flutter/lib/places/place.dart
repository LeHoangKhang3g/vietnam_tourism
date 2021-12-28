import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';

class PlacePost extends StatefulWidget {
  PlacePost({Key ?key , required this.place }):super(key:key); 
   @override
  _PlacePostState createState() => _PlacePostState();
  Place place;
  
  bool like=false;
  bool unlike=false;
}

class _PlacePostState extends State<PlacePost>{
  @override
  Widget build(BuildContext context){
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
                  padding: const EdgeInsets.fromLTRB(10 ,0 , 10 , 0),
                  child:  Text(
                    widget.place.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.place.area,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      widget.place.region,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ), 
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1),
            child: Text( 
              widget.place.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Image.asset(
            "images/"+widget.place.imageName,
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
                onPressed: (){},
                icon: const Icon(
                  Icons.comment,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.share,
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
