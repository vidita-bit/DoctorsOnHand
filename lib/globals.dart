import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


final String textBackground = "photos/trans.png";
final String background = "photos/bg.jpg";
final String logo = "photos/logo.png";
final String email = "photos/login_email.png";
final String pass = "photos/login_password.png";
final String emailHint = "Email Address";
final String passHint = "Password";
final double radius = 32;
final Color textColor = Colors.white;
final double chosenFontSize = 20;
final double allPadding = 20;
final double rightPadding = 10;
final double iconSize = 64;
final FirebaseStorage storage = FirebaseStorage.instance;
final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");
final CollectionReference adminCollection = FirebaseFirestore.instance.collection("Admin");
final DocumentReference IconsDoc = adminCollection.doc("Icons");
final DocumentReference rolesDoc = adminCollection.doc("Roles");
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
final Map keyMap = {conPassKey : passKey};

class Wrapper{
  Function? fxn;
  Wrapper(Function fxn){
    this.fxn = fxn;
  }
  Object? getItem(){
    return fxn!();
  }
}