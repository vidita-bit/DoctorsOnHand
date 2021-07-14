import 'auth.dart' as auth;
import 'base.dart' as base;
import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPage extends StatefulWidget{
  ResetPage({Key? key}) : super(key: key);
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage>{
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
                  base.BaseLogo(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  base.BaseBar(icon: globals.email, hint: globals.emailHint, validate: auth.emailError, barKey: globals.emailResetKey),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  SizedBox( 
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: base.BaseButton(text: "SUBMIT", primary: Colors.blue.shade700, secondary: globals.textColor, fontSize: globals.chosenFontSize, weight: FontWeight.bold, fxn: () {auth.onReset(context);})
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  base.BaseButton(text: "Remember your password? Log in", primary: globals.textColor, secondary: Colors.transparent, fontSize: globals.chosenFontSize * 0.75, fxn: () {Navigator.pop(context);}),

                ]
              )
            )
        )
      );
  }
}