import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'base.dart' as base;

class VerifyPage extends StatefulWidget{
  VerifyPage({Key? key}) : super(key: key);
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage>{
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
                  SizedBox( 
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: base.BaseButton(text: "Verify Email", primary: Colors.blue.shade700, secondary: globals.textColor, fontSize: globals.chosenFontSize, weight: FontWeight.bold, fxn: () {})
                  ),
                  
                ]
              )
            )
          )
        );
  }
}