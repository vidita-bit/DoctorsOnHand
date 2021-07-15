import 'package:validators/validators.dart';
import 'globals.dart' as globals;
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';
import 'package:fluttertoast/fluttertoast.dart';


class FireError {
  static bool emailError = false;
  static String? email = null;
  static bool credError = false;
  static void setEmailError(bool err){
    emailError = err;
  }

  static void setEmail(String? newEmail){
    email = newEmail;
  }

  static bool getEmailError(){
    return emailError;
  }

  static String? getEmail(){
    return email;
  }

  static bool handleCredError(bool change){
    bool tmp = credError;
    if (change){
      credError = !credError;
    }
    return tmp;
  }

}

String getApprovedSymbols(){
  return "!@#\$%^&*(){}[]-_=+\|><?/";
}
bool? passValidate(String pass){

  print(pass.length);
  if (pass.length < 8){
    return false;
  }
  
  List<bool> arr = [false,false,false,false];
  for (int i = 0; i < pass.length; i++){
    if (isNumeric(pass[i])){
      arr[0] = true;
    }

    else if(getApprovedSymbols().contains(pass[i])){
      arr[1] = true;
    }
    else if(isUppercase(pass[i])){
      arr[2] = true;
    }

    else if(isLowercase(pass[i])){
      arr[3] = true;
    }
    else{
      arr.add(false);
    }

  }
  

  if (arr.length > 4){
    return null;
  }
  else if (!arr.contains(false)){
    return true;
  }
  return false;
}

String? passError(String pass,var key){
  var returnValue = passValidate(pass);
  String returnString = "Invalid password!";

  if (returnValue == true){
    return null;
  }
  else if (returnValue == null){
    returnString = "Invalid character detected!";
  }
  return returnString;
}
String? confirmError(String confirm, var key){
  if (confirm != globals.keyMap[key].currentState.value){
    return "The passwords do not match!";
  }

  return null;
}

bool emailValidate(String email){
  bool valid = true;
  int atSeen = 0;
  int dotSeen = 0;
  for (int i = 0; i < email.length; i++){
    String c = email[i];
    if (c == "@"){
      atSeen++;
    }
    else if (c == "." && atSeen != 0){
      dotSeen++;
    }
    else if (!isAlphanumeric(c)){
      valid = false;
    }
  }
  if (atSeen != 1 || dotSeen != 1){
    valid = false;
  }

  return valid;
}

String? emailError(String email, var key){
  if (!emailValidate(email)){
    return "Please enter a valid email!";
  }
  if (FireError.getEmailError() || (email == FireError.getEmail())){
    FireError.setEmailError(false);
    return "That email address is already taken!";
  }
  FireError.setEmail(null);
  return null;
}


bool nameValidate(String name){
  if (name != ""){
    return false;
  }
  return true;
}

String? nameError(String name, var key){
  if (name.length != 0){
    return null;
  }
  String type = "first";
  if (key == globals.lNameKey || key == globals.lNameProfKey){
    type = "last";
  }
  return "Please provide a valid " + type + " name!";
}

String? loginError(String text,var key){
  print("reached3");
  String? response = passError(text, key);
  if (response != null){
    return response;
  }
  print(FireError.handleCredError(false));
  if (FireError.handleCredError(false)){
    print("rr");
    FireError.handleCredError(true);
    return "Invalid credentials!";
  }
  return null;
}
void createProfile(){
  String email = globals.emailKey.currentState!.value;
  String first = globals.fNameKey.currentState!.value;
  String last = globals.lNameKey.currentState!.value;
  String? phone = globals.phoneKey.currentState!.value;
  String pos = globals.roleKey.currentState!.value;
  UserProfile.createUser(email,first,last,phone,pos);
}

bool phoneValidate(String num){
  bool valid = true;
  for (int i = 0; i < num.length; i++){
    if (!isNumeric(num[i])){
      valid = false;
    }
  }
  return valid;
}

String? phoneError(String num, var key){
  if (phoneValidate(num)){
    return null;
  }
  return "Please only use numbers!";
}
void onReset(BuildContext context) async{
  String toast = "A reset link will be sent to your email if it is registered!";
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: globals.emailResetKey.currentState!.value);
  }
  catch (e){
    print(e);
  }
  Fluttertoast.showToast(msg: toast, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 5, backgroundColor: Colors.white, textColor: Colors.red, fontSize: 16.0);
  Navigator.pop(context);
}

bool roleValidate(String text){
  print(text.length == 0);
  if (text.length == 0){
    return false;
  }
  return true;
}

String? roleError(String text, var key){
  if (roleValidate(text)){
    return null;
  }
  return "Please select a role!";
}
void onLogin(BuildContext context) async{
  bool done = true;
  for (int i = 0; i < globals.loginKeys.length; i++){
    print(globals.loginKeys[i]);
    if (!globals.loginKeys[i].currentState!.validate()){
      done = false;
    }
  }
  if (done){
    try {
      globals.passLoginKey.currentState!.validate();
      print("reached");
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: globals.emailLoginKey.currentState!.value,
        password: globals.passLoginKey.currentState!.value
      );
      UserProfile.setUser();
      UserProfile.userSetup();
      Navigator.push(context,MaterialPageRoute(builder : (context) => HomePage(context: context)));
    }
    on FirebaseAuthException catch (e) {
      print("reached 2");
      print(e);
      FireError.handleCredError(true);
      globals.passLoginKey.currentState!.validate();
      print(FireError.handleCredError(false));
    }
    catch (e){
      print(e);
    }
  }
}
void onRegister(BuildContext context) async{
  bool done = true;
  for (int i = 0; i < globals.regKeys.length; i++){
    print(globals.regKeys[i]);
    if (!globals.regKeys[i].currentState!.validate()){
      done = false;
    }
  }
  print(done);

  if (done){
    String email = globals.emailKey.currentState!.value;
    String phone = globals.phoneKey.currentState!.value;
    print(email);
    try{
      print("reached");
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: globals.passKey.currentState!.value
      );
      UserProfile.setUser();
      createProfile();
      print("DOne");
      String toast = "Please check your email and verify it!";
      if (!UserProfile.getUser().emailVerified){
        UserProfile.getUser().sendEmailVerification();
      }
      else{
        toast = "Email already verified!";
      }
      Fluttertoast.showToast(msg: toast, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 5, backgroundColor: Colors.white, textColor: Colors.red, fontSize: 16.0);
      Navigator.push(context,MaterialPageRoute(builder : (context) => HomePage(context: context)));
    }
    on FirebaseAuthException catch (e){
      if (e.code == 'email-already-in-use'){
        FireError.setEmailError(true);
        FireError.setEmail(email);
        globals.emailKey.currentState!.validate();
      }
    }
    catch (e){
      print(e);
    }
  }

}




