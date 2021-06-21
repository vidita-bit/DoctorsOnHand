import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class RegPage extends StatefulWidget{
  RegPage({Key? key}) : super(key: key);
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage>{
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(globals.logo)
                    )
                  )
                )
              ]
            )
          )
        )
      );
  }
}