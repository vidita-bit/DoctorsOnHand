import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'base.dart' as base;
import 'auth.dart' as auth;

//similar spacing
class RegPage extends StatefulWidget {
  RegPage({Key? key}) : super(key: key);
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  bool finished = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(globals.background),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              base.BaseLogo(),
              //SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.2,
              //   height: MediaQuery.of(context).size.height * 0.05,
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Expanded(
              //         child: base.BaseText(
              //           text: "I am a ",
              //         ),
              //       ),
              //       Expanded(
              //         child: base.BaseDropDown(
              //           text: [],
              //           document: globals.rolesDoc,
              //           fieldName: "Roles",
              //           fxn: auth.roleError,
              //           dropKey: globals.roleKey,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(width:MediaQuery.of(context).size.width * (1/6), height: MediaQuery.of(context).size.height * 0.03, child: base.BaseCheck(text: "Doctor")),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              base.BaseBar(
                  offset: 0.02,
                  icon: "photos/name.png",
                  hint: "First Name",
                  validate: auth.nameError,
                  barKey: globals.fNameKey),
              base.BaseBar(
                  offset: 0.02,
                  icon: "photos/name.png",
                  hint: "Last Name",
                  validate: auth.nameError,
                  barKey: globals.lNameKey),
              base.BaseBar(
                  offset: 0.02,
                  icon: "photos/phone.png",
                  hint: "Phone Number (optional)",
                  validate: auth.phoneError,
                  barKey: globals.phoneKey),
              base.BaseBar(
                  offset: 0.02,
                  icon: globals.email,
                  hint: globals.emailHint,
                  validate: auth.emailError,
                  barKey: globals.emailKey),
              base.BaseBar(
                  offset: 0.02,
                  icon: globals.pass,
                  hint: globals.passHint,
                  validate: auth.passError,
                  obscure: true,
                  barKey: globals.passKey),
              base.BaseBar(
                  offset: 0.02,
                  icon: globals.pass,
                  hint: "Confirm " + globals.passHint,
                  validate: auth.confirmError,
                  obscure: true,
                  barKey: globals.conPassKey),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: base.BaseButton(
                      text: "REGISTER",
                      primary: Colors.blue.shade700,
                      secondary: globals.textColor,
                      fontSize: globals.chosenFontSize,
                      weight: FontWeight.bold,
                      fxn: () {
                        auth.onRegister(context);
                      })),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              base.BaseButton(
                text: "Have an account already? Log in",
                primary: globals.textColor,
                secondary: Colors.transparent,
                fontSize: globals.chosenFontSize * 0.75,
                fxn: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
