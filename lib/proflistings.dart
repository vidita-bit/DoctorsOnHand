import 'base.dart' as base;
import 'globals.dart' as globals;
import 'package:flutter/material.dart';

class Listings extends StatefulWidget {
  Listings({Key? key}) : super(key: key);

  @override
  _ListingsState createState() => _ListingsState();
    
}

class _ListingsState extends State<Listings> {
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
            body: Center(
              child: ListView(
                  children: <Widget>[
                      base.BaseLogo(),
                  ]
                )
            )
        )
      );
  }
}
