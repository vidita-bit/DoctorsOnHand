import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';


class UserProfile {
  static String email = "";
  static String first = "";
  static String last = "";
  static String? phone;
  static String role = "";
  static var user = null;

  static void setUser(){
    user = FirebaseAuth.instance.currentUser;
  }

  static void setEmail(String emailAdd){
    email = emailAdd;
  }

  static void setFName(String name){
    first = name;
  }
  static void setLName(String name){
    last = name;
  }
  static void setNum(String? number){
    phone = number;
  }

  static void setRole(String pos){
    role = pos;
  }
  static String getRole(){
    return role;
  }
  static String getEmail(){
    return email;
  }
  static String getFName(){
    return first;
  }
  static String getLName(){
    return last;
  }
  static String? getNum(){
    return phone;
  }
  static User getUser(){
    print(user);
    return user;
  }
  static String getUid(){
    return FirebaseAuth.instance.currentUser!.uid.toString();
  }
  static void setAll(String emailAdd, String firstName, String lastName, String? phoneNum, String pos) {
    setEmail(emailAdd);
    setFName(firstName);
    setLName(lastName);
    setNum(phoneNum);
    setRole(pos);
  }
  static void createUser(String emailAdd, String firstName, String lastName, String? phoneNum, String pos){
    setAll(emailAdd, firstName, lastName, phoneNum, pos);
    Map<String,dynamic> map = toMap();
    globals.userCollection.doc(getUid()).set(map).catchError((error) => print("new user failed $error"));
    var timestamp = FieldValue.serverTimestamp();
    globals.userCollection.doc(getUid()).update({"createdOn":timestamp,"usedOn":timestamp, "editedOn":timestamp}).catchError((error) => print("new user timestamp failed $error"));
  }

  static Map<String,dynamic> toMap(){
    return {"email" : getEmail(), "first" : getFName(), "last" : getLName(), "phone" : getNum(), "role" : getRole()};
  }

  static void userSetup(){
      globals.userCollection.doc(getUid()).update({"usedOn":FieldValue.serverTimestamp()}).catchError((error) => print("getting user failed $error"));
      globals.userCollection.doc(getUid()).get().then((d) {
        setAll(d['email'], d['first'], d['last'], d['phone'], d['role']);
      });
  }


}