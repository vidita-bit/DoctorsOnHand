import 'auth.dart' as auth;
import 'globals.dart' as globals;
import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor extends UserProfile{

  String? workEmail;
  String? workNum;
  String? workAddress;
  String? specialty;
  Doctor(meets, email,first, last, phone, imageAdd, roles, addresses, verifiedRoles, this.workEmail, this.workNum, this.workAddress, this.specialty) : super(meets,email, first, last, phone, imageAdd, roles, addresses, verifiedRoles, true) {
   
  }
  

  void setWorkEmail(String? email){
    if (email != null && auth.emailValidate(email)){
      workEmail = email;
    }
  }

  void setWorkNum(String? number){
    if (number != null && auth.phoneValidate(number)){
        workNum = number;
        print("YASS");
    }
  }

  void setWorkAddress(String? addy){
    workAddress = addy;
  }

  void setSpecialty(String? spec){
    if (spec != null && auth.nameValidate(spec)){
      specialty = spec;
    }
  }

 
  String? getWorkEmail(){
    return workEmail;
  }

  String? getWorkNum(){
    return workNum;
  }

  String? getWorkAddress(){
    return workAddress;
  }
  String? getSpecialty(){
    return specialty;
  }

  List<dynamic> getList(){
    return [workEmail,workNum,workAddress,specialty];
  }
  bool canList(){
    bool listable = true;
    List<dynamic> items = getList();
    for (int i = 0; i < items.length; i++){
      print(items[i]);
      if (items[i] == null){
        listable = false;
      }
    }
    return listable;
  }

  void setAllDoc(String? email, String? add, String? phone, String? spec){
    print("SETALL");
    print(phone);
    setWorkEmail(email);
    setWorkNum(phone);
    setWorkAddress(add);
    setSpecialty(spec);
  }


  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = super.toMap();
    print("BABDBABABA");
    map.addAll({"doctorEditedOn": FieldValue.serverTimestamp(), "workEmail": getWorkEmail(), "workNum": getWorkNum(), "workAddress": getWorkAddress(), "specialty": getSpecialty()});
    print(map);
    return map;
  }
  
}