import 'auth.dart' as auth;
import 'globals.dart' as globals;
import 'user.dart';
import 'calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor extends UserProfile{
  List<dynamic> meets = [];
  List<Meeting> appts = [];
  Map<Meeting,int> meetMap = {};
  String? workEmail;
  String? workNum;
  String? workAddress;
  String? specialty;
  Doctor(email,first, last, phone, imageAdd, roles, addresses, verifiedRoles, this.meets, this.workEmail, this.workNum, this.workAddress, this.specialty) : super(email, first, last, phone, imageAdd, roles, addresses, verifiedRoles, true) {
    for (int i = 0; i < meets.length; i++){
      Meeting meeting = Meeting.toMeeting(meets[i]);
      appts.add(meeting);
      meetMap[meeting] = i;
    }
  }
  int meetingToInt(Meeting meeting){
    return meetMap[meeting]!;
  }
  void setAppts(List<Meeting>  meetings){
    appts = meetings;
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

  List<Meeting> getAppts(){
    return appts;
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

  dynamic convertMeetings(){
    List<dynamic> jsons = [];
    for (int i = 0; i < appts.length; i++){
      jsons.add(appts[i].toJson());
    }

    return {"Appts": jsons};
  }

  void saveAppts(List<Meeting>  meetings){
    setAppts(meetings);
   Map<String,dynamic> jsons = convertMeetings();
    Map<String,dynamic> map = {"doctorApptEditedOn": FieldValue.serverTimestamp()};
    map.addAll(jsons);
    globals.user.updateUser(map,edited:false);
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