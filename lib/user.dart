import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'calendar.dart';
import 'auth.dart' as auth;
import 'db.dart';
import 'doctor.dart';

//check verifiedroles after registration and alphavetic insertion

class UserProfile {
  List<dynamic> meets = [];
  Map<Meeting,int> meetMap = {};
  List<Meeting> appts = [];
  String email = "";
  String first = "";
  String last = "";
  String phone = "";
  String? imageAddress;
  bool changed = false;
  List<String> requests;
  List<String> addresses;
  List<String> verifiedRoles;
  var user = null;
  String? uid = null;
  bool doctor;

  UserProfile(this.meets, this.email,this.first,this.last,this.phone,this.imageAddress, this.requests, this.addresses, this.verifiedRoles, this.doctor, {this.uid}){
     for (int i = 0; i < meets.length; i++){
      Meeting meeting = Meeting.toMeeting(meets[i]);
      appts.add(meeting);
      meetMap[meeting] = i;
    }
  }
  int meetingToInt(Meeting meeting){
    return meetMap[meeting]!;
  }
  static void createUser(String emailAdd, String firstName, String lastName, String phoneNum){
    globals.user = UserProfile([],emailAdd, firstName, lastName, phoneNum,null,[],[],[],false);
    globals.user.setUser();
    Map<String,dynamic> map = globals.user.toMap();
    var timestamp = FieldValue.serverTimestamp();
    map.addAll({"createdOn":timestamp,"usedOn":timestamp, "editedOn":timestamp});
    print(map);
    createDoc(map,globals.userCollection.doc(globals.user.getUid()));
  }
  dynamic convertMeetings(){
    List<dynamic> jsons = [];
    for (int i = 0; i < appts.length; i++){
      jsons.add(appts[i].toJson());
    }

    return {"Appts": jsons};
  }

  void saveAppts(List<Meeting> meetings, bool? hadNull){
    print(meetings);
    print(getUid());
    setAppts(meetings,hadNull);
    Map<String,dynamic> jsons = convertMeetings();
    Map<String,dynamic> map = {"lastUserBooking": FieldValue.serverTimestamp()};
    map.addAll(jsons);
    updateUser(map,edited:false);
  }
  void setChanged(bool b){
    changed = b;
  }
  void setUser(){
    user = globals.auth.currentUser;
    uid = globals.auth.currentUser!.uid.toString();
  }

  void addAppt(Meeting appt){
    appts.add(appt);
  }

  void setAddresses(List<String> a){
    addresses = a;
  }
  void addAddress(String address){
    addresses.add(address);
  }

  void setVerifiedRoles(List<String> roles){
    verifiedRoles = roles;
  }
  void addVerifiedRole(String role){
    verifiedRoles.add(role);
  }
  void setEmail(String emailAdd){
    if (auth.emailValidate(emailAdd)){
      email = emailAdd;
    }
  }

  void setFName(String name){
    print(name);
    print(auth.nameValidate(name));
    if (auth.nameValidate(name)){
      first = name;
    }
  }
  void setImageAdd(String imageAdd){
    print("SETTING ADDRESS");
    print(imageAdd);
    imageAddress = imageAdd;
  }
  void setLName(String name){
    if (auth.nameValidate(name)){
      last = name;
    }
  }
  void setNum(String number){
    if (auth.phoneValidate(number)){
      phone = number;
    }
  }

  void setAppts(List<Meeting>  meetings, bool? hadNull){
    List<Meeting> finalList = [];
    if (hadNull == null){
      appts = meetings;
    }
    for (int i = 0; i < appts.length; i++){
      if (hadNull == true && appts[i].user != null){
        finalList.add(appts[i]);
      }
      else if (hadNull == false && appts[i].user == null){
        finalList.add(appts[i]);
      }
    }

    appts = finalList + meetings;
  }
  void setRequests(List<String> reqs){
    requests = reqs;
  }


  bool addRequest(String request){
    if (!requests.contains(request)){
      requests.add(request);
      return true;
    }
    return false;
  }

void sendRequest(String value){
    print(value);
    DocumentReference document = globals.reqCollection.doc(getUid());
    print(value);
    if (value != ""){
      bool added = addRequest(value);
      if (added){
        document.set({
          value + " requests": FieldValue.arrayUnion([Timestamp.now()])
        }, SetOptions(merge: true));
      }
    }
  }
 List<String> getAddresses(){
    return addresses;
  }
  
  bool isDoc(){
    return doctor;
  }
  String? getImageAdd(){
    return imageAddress;
  }

  List<String> getVerifiedRoles(){
    return verifiedRoles;
  }
  String getEmail(){
    print("THIS");
    return email;
  }
  String getFName(){
    return first;
  }
  String getLName(){
    return last;
  }
  String getNum(){
    return phone;
  }

  List<Meeting> getAppts(bool? wantNull){
    if (wantNull == null){
      return appts;
    }
    List<Meeting> finalList = [];
    for (int i = 0; i < appts.length; i++){
      if (wantNull == true && appts[i].user == null){
        finalList.add(appts[i]);
      }
      else if (wantNull == false && appts[i].user != null){
        finalList.add(appts[i]);
      }
    }
    return finalList;
  }
  User getUser(){
    print(user);
    return user;
  }
  List<String> getRequests(){
    return requests;
  }
  String getUid(){
    return uid!;
  }
  void setAll(String emailAdd, String firstName, String lastName, String phoneNum, List<String> addresses,List<Meeting> appts, bool? wantNull) { 
    setAppts(appts, wantNull);
    setEmail(emailAdd);
    setFName(firstName);
    setLName(lastName);
    setNum(phoneNum);
    if (addresses != null){
      setAddresses(addresses);
    }

    
    print("TTHIS HAS BEEEN SET ADAM!!!!");
  }
  void profileUpdate(String emailAdd, String firstName, String lastName, String phoneNum,var image, List<String> addresses, List<Meeting> appts, bool? nullAppts){
    bool updated = false;
    setAll(emailAdd,firstName,lastName,phoneNum,addresses, appts, nullAppts);
    if (changed && imageAddress != null){
      changed = false;
      print("DELETION");
      globals.storage.refFromURL(imageAddress!).delete();
      if (image == null){
        imageAddress = null;
        updateUser(toMap());
        updated = true;
      }
    }
    if (image != null){
      changed = false;
      print("UPLOAD");
      uploadImage(image);
      updated = true;
    }

    if (!updated){
      updateUser(toMap());
    }
  }
  void logOut(){
    updateUser({"loggedOutOn": FieldValue.serverTimestamp()}, edited: false);
  }
  void uploadImage(var image) async{
      Reference reference = globals.storage.ref().child("patientpics/${getUid()}/upload");
      print(reference);
      UploadTask task = reference.putData(image!);
      (await task).ref.getDownloadURL().then(
        (val) {
          print(val);
          setImageAdd(val);
          updateUser(toMap());
        }
      );
  }
  void updateUser(var map, {bool edited = true}){
    if (edited){
      map["editedOn"] = FieldValue.serverTimestamp();
    }
    print(map);
    updateDoc(map,globals.userCollection.doc(getUid()));
  }
 

  Map<String,dynamic> toMap(){
    print("TOMAP");
    Map<String,dynamic> map =  {"email" : getEmail(), "first" : getFName(), "last" : getLName(), "phone" : getNum(), "requests" : getRequests(),"image": getImageAdd(), "addresses": getAddresses(), "verifiedRoles": getVerifiedRoles()};
    Map<String,dynamic> jsons = convertMeetings();
    map.addAll(jsons);
    return map;
  }

  static void userSetup(){
      print("THIS WAS CALLED");
      String uid = globals.auth.currentUser!.uid.toString();
      globals.userCollection.doc(uid).update({"usedOn":FieldValue.serverTimestamp()}).catchError((error) => print("getting user failed $error"));
      globals.userCollection.doc(uid).get().then((d) {
      print(uid);
      print(d.data());
      List<String> verified = List<String>.from(d['verifiedRoles']);
      if (verified.contains(globals.hp)){
        globals.user = Doctor(d["Appts"], d['email'], d['first'], d['last'], d['phone'], d['image'],List<String>.from(d['requests']), List<String>.from(d['addresses']), verified, d['workEmail'],d['workNum'], d['workAddress'], d['specialty']);
      }
      else{
        globals.user = UserProfile(d['Appts'],d['email'], d['first'], d['last'], d['phone'], d['image'], List<String>.from(d['requests']), List<String>.from(d['addresses']), verified, false);
      }
        globals.user.setUser();
      });
  }


}