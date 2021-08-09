import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'displayCal.dart';
import 'doctor.dart';
class MyListing extends StatefulWidget{
  MyListing({Key? key, required this.doc}) : super(key: key);
  Doctor doc;
  @override
  _MyListingState createState() => _MyListingState();
}

class _MyListingState extends State<MyListing>{
  
  @override
  Widget build(BuildContext context){
    return Container( 
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(globals.background),
            fit: BoxFit.cover,
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: <Widget>[
              EventCalendar(doc: widget.doc)
            ]
          )
        )
      );
  }
}