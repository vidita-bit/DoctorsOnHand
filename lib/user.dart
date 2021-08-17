import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'auth.dart' as auth;
import 'db.dart';
import 'doctor.dart';

//check verifiedroles after registration and alphavetic insertion

class UserProfile {
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

  UserProfile(this.email,this.first,this.last,this.phone,this.imageAddress, this.requests, this.addresses, this.verifiedRoles, this.doctor);

  static void createUser(String emailAdd, String firstName, String lastName, String phoneNum){
    globals.user = UserProfile(emailAdd, firstName, lastName, phoneNum,null,[],[],[],false);
    globals.user.setUser();
    Map<String,dynamic> map = globals.user.toMap();
    createDoc(map,globals.userCollection.doc(globals.user.getUid()));
    var timestamp = FieldValue.serverTimestamp();
    globals.user.updateUser({"createdOn":timestamp,"usedOn":timestamp, "editedOn":timestamp});
  }

  void setChanged(bool b){
    changed = b;
  }
  void setUser(){
    user = globals.auth.currentUser;
    uid = globals.auth.currentUser!.uid.toString();
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
  void setAll(String emailAdd, String firstName, String lastName, String phoneNum, {List<String>? addresses = null}) { 
    setEmail(emailAdd);
    setFName(firstName);
    setLName(lastName);
    setNum(phoneNum);
    if (addresses != null){
      setAddresses(addresses);
    }

    
    print("TTHIS HAS BEEEN SET ADAM!!!!");
  }
  void profileUpdate(String emailAdd, String firstName, String lastName, String phoneNum,var image, List<String> addresses){
    bool updated = false;
    setAll(emailAdd,firstName,lastName,phoneNum, addresses: addresses);
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
    return {"email" : getEmail(), "first" : getFName(), "last" : getLName(), "phone" : getNum(), "requests" : getRequests(),"image": getImageAdd(), "addresses": getAddresses(), "verifiedRoles": getVerifiedRoles()};
   
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
        globals.user = Doctor(d['email'], d['first'], d['last'], d['phone'], d['image'],List<String>.from(d['requests']), List<String>.from(d['addresses']), verified, d["Appts"], d['workEmail'],d['workNum'], d['workAddress'], d['specialty']);
      }
      else{
        globals.user = UserProfile(d['email'], d['first'], d['last'], d['phone'], d['image'], List<String>.from(d['requests']), List<String>.from(d['addresses']), verified, false);
      }
        globals.user.setUser();
      });
  }


}