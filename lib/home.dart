import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'base.dart' as base;

class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(globals.background),
            fit: BoxFit.cover,
          ),
        ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  base.BaseLogo(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  
                ]
              )
            )
          )
        );
  }
}