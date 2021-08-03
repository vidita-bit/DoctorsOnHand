import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


final String textBackground = "photos/trans.png";
final String background = "photos/bg.jpg";
final String logo = "photos/logo.png";
final String email = "photos/login_email.png";
final String pass = "photos/login_password.png";
final String address = "photos/address.png";
final String emailHint = "Email Address";
final String passHint = "Password";
final String baseRole = "Patient";
final double radius = 32;
final String font = "Roboto";
final Color textColor = Colors.white;
final double chosenFontSize = 20;
final double allPadding = 20;
final double rightPadding = 10;
final double iconSize = 64;
final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference userCollection = firestore.collection("Users");
final CollectionReference reqCollection = firestore.collection("Requests");
final CollectionReference adminCollection = firestore.collection("Admin");
final DocumentReference iconsDoc = adminCollection.doc("Icons");
final DocumentReference rolesDoc = adminCollection.doc("Roles");
final GlobalKey<FormFieldState> roleProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> emailProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> fNameProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> lNameProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> phoneProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> roleKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> passKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> conPassKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> fNameKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> lNameKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> passLoginKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> emailLoginKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> emailResetKey = GlobalKey<FormFieldState>();
final List<GlobalKey<FormFieldState>> loginKeys = [passLoginKey, emailLoginKey];
final List<GlobalKey<FormFieldState>> regKeys = [passKey, conPassKey, emailKey, fNameKey, lNameKey, roleKey, phoneKey];
// final List<GlobalKey<FormFieldState>> profKeys = [emailProfKey, fNameProfKey, lNameProfKey, phoneProfKey];

final Map keyMap = {conPassKey : passKey};


class ObjWrapper{
  var item;
  ObjWrapper(dynamic item){
    this.item = item;
  }
  dynamic getItem(){
    return item;
  }

  void setItem(dynamic item){
    this.item = item;
  }

}
class Wrapper{
  Function? fxn;
  Wrapper(Function fxn){
    this.fxn = fxn;
  }
  Object? getItem(){
    return fxn!();
  }
}

class Alert{
  bool? raised = null;
  
  void change(bool alert){
    raised = alert;
  }

  bool? check(){
    return raised;
  }
}