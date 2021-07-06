import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';


class UserProfile {
  static String email = "";
  static String first = "";
  static String last = "";
  static String? phone;
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

  static void createUser(String emailAdd, String firstName, String lastName, String? phoneNum){
    setEmail(emailAdd);
    setFName(firstName);
    setLName(lastName);
    setNum(phoneNum);
    Map<String,dynamic> map = toMap();
    globals.userCollection.doc(getUid()).set(map).catchError((error) => print("new user failed $error"));
  }

  static Map<String,dynamic> toMap(){
    return {"email" : getEmail(), "first" : getFName(), "last" : getLName(), "phone" : getNum()};
  }


}