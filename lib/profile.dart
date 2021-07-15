import 'package:flutter/material.dart';
import 'base.dart' as base;
import 'globals.dart' as globals;
import 'user.dart';
import 'auth.dart' as auth;
import 'dart:math';
import 'dart:core';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfilePage extends StatefulWidget{
  ProfilePage({Key? key}) : super(key: key);
  List<String> possibleRoles = List.empty();
  final String role = UserProfile.getRole();
  final String first = UserProfile.getFName();
  final String last = UserProfile.getLName();
  final String? num = UserProfile.getNum();
  final String email = UserProfile.getEmail();
  final Color randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{

  @override
  Widget build(BuildContext context){
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(globals.background),
            fit: BoxFit.cover,
          )
        ),
        child: SingleChildScrollView(child: SizedBox(height: MediaQuery.of(context).size.height * 0.8, 
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: AppBar(
                          title: Text(''),// You can add title here
                          leading: IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        backgroundColor: Colors.transparent, //You can make this transparent
                        elevation: 0.0, //No shadow
                      ),),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      base.BaseLogo(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.15, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [
                        Container(height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.15, child: Center(child: Text((widget.first[0]+ widget.last[0]).toUpperCase(), style: TextStyle(color: globals.textColor, fontSize: 40, fontWeight: FontWeight.bold))), decoration: BoxDecoration(color: widget.randomColor, shape: BoxShape.circle)),
                        Text(widget.role.toUpperCase(), style: TextStyle(color: globals.textColor, fontSize: 40, fontWeight: FontWeight.bold))])),
                      Container(width: MediaQuery.of(context).size.width * 0.25, height: MediaQuery.of(context).size.width * 0.05, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [
                        Expanded(child: Text("I am also a", style: TextStyle(color: globals.textColor, fontSize: globals.chosenFontSize))),
                        Expanded(child: base.BaseDropDown(document: globals.rolesDoc, fieldName: (widget.role + " Ranks"), fxn: () {},dropKey: globals.roleProfKey, mode: AutovalidateMode.disabled)),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        Expanded(child: base.BaseButton(text: "SUBMIT", primary: Colors.blue, secondary: globals.textColor, fontSize: globals.chosenFontSize * 0.75, fxn: onSubmit))
                      ])),
                      base.BaseBar(initialValue: widget.first, icon: "photos/name.png", hint: "First Name", validate: auth.nameError, barKey: globals.fNameKey),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      base.BaseBar(initialValue: widget.last, icon: "photos/name.png", hint: "Last Name",validate: auth.nameError, barKey: globals.lNameProfKey),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      base.BaseBar(initialValue: widget.num, icon: "photos/phone.png", hint: "Phone Number", validate: auth.phoneError, barKey: globals.phoneProfKey),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      base.BaseBar(initialValue: widget.email, icon: globals.email, hint: globals.emailHint, validate: auth.emailError, barKey: globals.emailProfKey),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      
              ]
            )
          )
        )
      )));
  }
}

void onSubmit(){
  String value = globals.roleProfKey.currentState!.value;
  DocumentReference document = globals.reqCollection.doc(UserProfile.getUid());
  print(value);
  if (value != ""){
    document.set({
      value + " requests pending": FieldValue.arrayUnion([Timestamp.now()])
    });
  }
}
