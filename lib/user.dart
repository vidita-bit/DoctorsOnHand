import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'db.dart';
import 'doctor.dart';

//check verifiedroles after registration and alphavetic insertion

class UserProfile {
  static String email = "";
  static String first = "";
  static String last = "";
  static String? phone;
  static String? imageAddress = null;
  static bool changed = false;
  static List<String> requests = [];
  static List<String> addresses = [];
  static List<String> verifiedRoles = [];
  static var user = null;
  static Doctor? doc;

  static void setChanged(bool b){
    changed = b;
  }
  static void setUser(){
    user = FirebaseAuth.instance.currentUser;
  }

  static void createDoctor(var map){
    doc = Doctor(map);
  }

  static void setAddresses(List<String> a){
    addresses = a;
  }
  static void addAddress(String address){
    addresses.add(address);
  }

  static void setVerifiedRoles(List<String> roles){
    verifiedRoles = roles;
  }
  static void addVerifiedRole(String role){
    verifiedRoles.add(role);
  }
  static void setEmail(String emailAdd){
    email = emailAdd;
  }

  static void setFName(String name){
    first = name;
  }
  static void setImageAdd(String imageAdd){
    print("SETTING ADDRESS");
    print(imageAdd);
    imageAddress = imageAdd;
  }
  static void setLName(String name){
    last = name;
  }
  static void setNum(String? number){
    phone = number;
  }

  static void setRequests(List<String> reqs){
    requests = reqs;
  }


  static bool addRequest(String request){
    if (!requests.contains(request)){
      requests.add(request);
      return true;
    }
    return false;
  }

static void sendRequest(String value){
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
static List<String> getAddresses(){
    return addresses;
  }
  
  static Doctor? getDoctor(){
    return doc;
  }
  static String? getImageAdd(){
    return imageAddress;
  }

  static List<String> getVerifiedRoles(){
    return verifiedRoles;
  }
  static String getEmail(){
    print("THIS");
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
  static List<String> getRequests(){
    return requests;
  }
  static String getUid(){
    return FirebaseAuth.instance.currentUser!.uid.toString();
  }
  static void setAll(String emailAdd, String firstName, String lastName, String? phoneNum, {var map = null, String? imageAdd = null, List<String>? addresses = null, List<String>? verifiedRoles = null, List<String>? roles = null}) { 
    setEmail(emailAdd);
    setFName(firstName);
    setLName(lastName);
    setNum(phoneNum);
    if (imageAdd != null){
      print("current address");
      print(imageAdd);
      setImageAdd(imageAdd);
    }
  
    if (verifiedRoles != null){
      setAddresses(addresses!);
      setRequests(roles!);
      setVerifiedRoles(verifiedRoles);
      if (verifiedRoles.contains(globals.hp)){
        createDoctor(map!);
      }
    }

    
    print("TTHIS HAS BEEEN SET ADAM!!!!");
  }
  static void profileUpdate(String emailAdd, String firstName, String lastName, String? phoneNum,var image, List<String>? addresses){
    setAll(emailAdd,firstName,lastName,phoneNum);
    if (changed && imageAddress != null){
      changed = false;
      print("DELETION");
      globals.storage.refFromURL(imageAddress!).delete();
      if (image == null){
        imageAddress = null;
        updateUser(toMap());
      }
    }
    if (image != null){

      changed = false;
      print("UPLOAD");
      uploadImage(image);
    }
  }
  static void uploadImage(var image) async{
      Reference reference = globals.storage.ref().child("patientpics/${getUid()}/upload");
      print(reference);
      print(image);
      UploadTask task = reference.putData(image!);
      (await task).ref.getDownloadURL().then(
        (val) {
          print(val);
          setImageAdd(val);
          updateUser(toMap());
        }
      );
  }
  static void updateUser(var map){
    map["editedOn"] = FieldValue.serverTimestamp();
    updateDoc(map,globals.userCollection.doc(getUid()));
  }
  static void createUser(String emailAdd, String firstName, String lastName, String? phoneNum){
    setAll(emailAdd, firstName, lastName, phoneNum, imageAdd: imageAddress);
    Map<String,dynamic> map = toMap();
    map["verifiedRoles"] = [];
    createDoc(map,globals.userCollection.doc(getUid()));
    var timestamp = FieldValue.serverTimestamp();
    updateUser({"createdOn":timestamp,"usedOn":timestamp, "editedOn":timestamp});
  }

  static Map<String,dynamic> toMap(){
    print("TOMAP");
    var map = {"email" : getEmail(), "first" : getFName(), "last" : getLName(), "phone" : getNum(), "requests" : getRequests(),"image": getImageAdd(), "addresses": getAddresses()};
    if (getDoctor() != null){
      map = getDoctor()!.toMap(map);
    }
    return map;
  }

  static void userSetup(){
      print("THIS WAS CALLED");
      globals.userCollection.doc(getUid()).update({"usedOn":FieldValue.serverTimestamp()}).catchError((error) => print("getting user failed $error"));
      globals.userCollection.doc(getUid()).get().then((d) {
        print("done");
        print(getUid());
        try{
          setAll(d['email'], d['first'], d['last'], d['phone'], map: d, imageAdd: d['image'],roles: List<String>.from(d['requests']), addresses: List<String>.from(d['addresses']), verifiedRoles: List<String>.from(d['verifiedRoles']));
        }
        catch (e){
          print("THIS HAS BEEN CAUGHT");
        }
      });
  }


}