import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/places/place.dart';



class PlaceScreen extends StatefulWidget{
  const PlaceScreen({Key?key}):super(key: key);
  @override
  _PlaceScreenState createState()=> _PlaceScreenState();
}
class _PlaceScreenState extends State<PlaceScreen>{
  List<Place> places = [
    Place("Nha Trang","Miền Trung", "Khu Vực Trung Bộ" , "Khám phá ngay trung tâm thành phố Nha Trang có gì chơi" , "place1.jpg"),
    Place("Thừa Thiên Huế","Miền Trung","Khu Vực Trung Bộ","phong cách đẹp" , "place2.jpg"),
    Place("Vịnh Hạ Long" , "Miền Bắc" , "Khu Vực Bắc Bộ", "Phong cách đẹp" , "place3.jpg"),


  ];

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: places.length,

      itemBuilder: (BuildContext context , index) {
        return PlacePost(place: places[index]);

      }, 
     
     );
     
  }
}


