import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/models/account.dart';

class PlacePost extends StatefulWidget {
  PlacePost({Key ?key , required this.place }):super(key:key); 
   @override
  _PlacePostState createState() => _PlacePostState();
  Place place;
  

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
                      ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       widget.place.area,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.place.region,
                        style: const TextStyle(
                          fontSize: 12,
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
            
          ],
        ),
        
      );
    }

}  
