import 'package:flutter/material.dart';
import 'package:vietnam_tourism_flutter/main.dart';
import 'package:vietnam_tourism_flutter/models/place.dart';
import 'package:vietnam_tourism_flutter/places/place.dart';



class PlaceScreen extends StatefulWidget{
  const PlaceScreen({Key?key}):super(key: key);
  @override
  _PlaceScreenState createState()=> _PlaceScreenState();
}
class _PlaceScreenState extends State<PlaceScreen>{

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: MyApp.repository.places.length,

      itemBuilder: (BuildContext context , index) {
        return PlacePost(place: MyApp.repository.places.elementAt(index));

      }, 
     
     );
     
  }
}


