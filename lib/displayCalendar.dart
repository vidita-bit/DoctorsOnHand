import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'calendar.dart';
import 'doctor.dart';
class Calendar extends StatefulWidget{
  Calendar({Key? key, required this.doc, this.enabled = true}) : super(key: key);
  var doc;
  bool enabled;
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>{
  
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
              EventCalendar(doc: widget.doc, enabled: widget.enabled)
            ]
          )
        )
      );
  }
}