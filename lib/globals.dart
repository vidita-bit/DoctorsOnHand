import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';
//same day 
//back button same as press
//last login
List<Color> colorCollection = [Color(0xFF0F8644),Color(0xFF8B1FA9),Color(0xFFD20100),Color(0xFFFC571D),Color(0xFF85461E), Color(0xFFFF00FF),Color(0xFF3D4FB5),Color(0xFFE47C73),Color(0xFF636363)];
List<String> colorNames = ["Green", "Purple", "Red","Orange", "Caramel", "Magenta","Blue","Peach","Gray"];

var user;
final String apiKey = "AIzaSyCr7jn8bWfmolToBtrxDhAChpe8fy0MQ_4";
final String textBackground = "photos/trans.png";
final String background = "photos/bg.jpg";
final String logo = "photos/logo.png";
final String email = "photos/login_email.png";
final String pass = "photos/login_password.png";
final String dicon = "photos/dicon.png";
final String address = "photos/address.png";
final String emailHint = "Email Address";
final String passHint = "Password";
final String baseRole = "Patient";
final double radius = 32;
final String font = "Roboto";
final String hp = "Medical Professional";
final Color textColor = Colors.white;
final double chosenFontSize = 20;
final double allPadding = 20;
final double rightPadding = 10;
final double iconSize = 64;
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference indexCollection = firestore.collection("Indexes");
final DocumentReference doctorIndexDoc = indexCollection.doc(hp);
final CollectionReference userCollection = firestore.collection("Users");
final CollectionReference reqCollection = firestore.collection("Requests");
final CollectionReference adminCollection = firestore.collection("Admin");
final DocumentReference iconsDoc = adminCollection.doc("Icons");
final DocumentReference rolesDoc = adminCollection.doc("Roles");
final GlobalKey<FormFieldState> roleProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> emailProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> workEmailProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> workAddressProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> workSpecialtyProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> fNameProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> lNameProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> phoneProfKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> workPhoneProfKey = GlobalKey<FormFieldState>();
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
