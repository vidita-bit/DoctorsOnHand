import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'base.dart' as base;
//similar spacing
class RegPage extends StatefulWidget{
  RegPage({Key? key}) : super(key: key);
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage>{
  bool finished = false;
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                base.BaseLogo(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                base.BaseText(text: "Select any additional roles you wish to apply for: "),
                Container(width:MediaQuery.of(context).size.width * (1/6), height: MediaQuery.of(context).size.height * 0.03, child: base.BaseCheck(text: "Doctor")),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                base.BaseBar(icon: "photos/name.png", hint: "First Name", validate: () {}),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                base.BaseBar(icon: "photos/name.png", hint: "Last Name",validate: () {}),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                base.BaseBar(icon: "photos/phone.png", hint: "Phone Number", validate: () {}),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                base.BaseBar(icon: globals.email, hint: globals.emailHint, validate: () {}),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                base.BaseBar(icon: globals.pass, hint: globals.passHint, validate: () {}),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                base.BaseBar(icon: globals.pass, hint: "Confirm " + globals.passHint, validate: () {}),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SizedBox( 
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: base.BaseButton(text: "REGISTER", primary: Colors.blue.shade700, secondary: globals.textColor, fontSize: globals.chosenFontSize, weight: FontWeight.bold, fxn: () {})

                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  base.BaseButton(text: "Have an account already? Log in", primary: globals.textColor, secondary: Colors.transparent, fontSize: globals.chosenFontSize * 0.75, fxn: () {Navigator.pop(context);})
              ]
            )
          )
        )
      );
  }
}