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
  bool? _dChosen = false;
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
                base.BaseText(text: "Select any roles you wish to apply for: "),
                Container(width:MediaQuery.of(context).size.width * (1/6), height: MediaQuery.of(context).size.height * 0.03, child: base.BaseCheck(text: "Doctor")),
                Container(width:MediaQuery.of(context).size.width * (1/6), height: MediaQuery.of(context).size.height * 0.03, child: base.BaseCheck(text: "Administrator")),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                base.BaseBar(icon: "photos/name.png", hint: "First Name"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                base.BaseBar(icon: "photos/name.png", hint: "Last Name"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                base.BaseBar(icon: "photos/phone.png", hint: "Phone Number"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                base.BaseBar(icon: globals.email, hint: globals.emailHint),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                base.BaseBar(icon: globals.pass, hint: globals.passHint),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                base.BaseBar(icon: globals.pass, hint: "Confirm " + globals.passHint),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SizedBox( //fuck
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue.shade700,
                        backgroundColor: globals.textColor,
                        textStyle: TextStyle(fontSize: globals.chosenFontSize, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(globals.radius/2)
                        )
                      ),
                      onPressed: () {},
                      child: const Text('REGISTER'),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  TextButton( //fuck
                    style: TextButton.styleFrom(
                      primary: globals.textColor,
                      backgroundColor: Colors.transparent,
                      textStyle: TextStyle(fontSize: globals.chosenFontSize * 0.75),
                    ),
                    onPressed: () {Navigator.pop(context);},
                    child: Text("Have an account already? Log in"),
                  ),
              ]
            )
          )
        )
      );
  }
}