import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class MyListing extends StatefulWidget{
  MyListing({Key? key, required this.enabled}) : super(key: key);
  bool enabled;
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                ]
              )
            ]
          )
        )
      );
  }
}