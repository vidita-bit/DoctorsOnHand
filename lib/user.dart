import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
//check verifiedroles after registration and alphavetic insertion

class UserProfile {
  static String email = "";
  static String first = "";
  static String last = "";
  static String? phone;
  static List<String> requests = [];
  static List<String> addresses = [];
  static List<String> verifiedRoles = [];
  static var user = null;

  static void setUser(){
    user = FirebaseAuth.instance.currentUser;
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
  static List<String> getAddresses(){
    return addresses;
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
  static void setAll(String emailAdd, String firstName, String lastName, String? phoneNum, {List<String>? addresses = null, List<String>? verifiedRoles = null, String? role = null, List<String>? roles = null}) { 
    setEmail(emailAdd);
    setFName(firstName);
    setLName(lastName);
    setNum(phoneNum);
    if (role != null && role != globals.baseRole){
      addRequest(role);
    }
    if (addresses != null){
      setAddresses(addresses);
    }
    if (verifiedRoles != null){
      setVerifiedRoles(verifiedRoles);
    }
    if (roles != null){
      setRequests(roles);
    }
    print("TTHIS HAS BEEEN SET ADAM!!!!");
  }
  static void createUser(String emailAdd, String firstName, String lastName, String? phoneNum, String pos){
    setAll(emailAdd, firstName, lastName, phoneNum, role: pos);
    Map<String,dynamic> map = toMap();
    map["verifiedRoles"] = [];
    map['addresses'] = [];
    globals.userCollection.doc(getUid()).set(map).catchError((error) => print("new user failed $error"));
    var timestamp = FieldValue.serverTimestamp();
    globals.userCollection.doc(getUid()).update({"createdOn":timestamp,"usedOn":timestamp, "editedOn":timestamp}).catchError((error) => print("new user timestamp failed $error"));
  }

  static Map<String,dynamic> toMap(){
    print("TOMAP");
    return {"email" : getEmail(), "first" : getFName(), "last" : getLName(), "phone" : getNum(), "requests" : getRequests(), "addresses": FieldValue.arrayUnion(getAddresses())};
  }

  static void userSetup(){
      print("THIS WAS CALLED");
      globals.userCollection.doc(getUid()).update({"usedOn":FieldValue.serverTimestamp()}).catchError((error) => print("getting user failed $error"));
      globals.userCollection.doc(getUid()).get().then((d) {
        print("done");
        print(getUid());
        try{
        setAll(d['email'], d['first'], d['last'], d['phone'], roles: List<String>.from(d['requests']), addresses: List<String>.from(d['addresses']), verifiedRoles: List<String>.from(d['verifiedRoles']));
        }
        catch (e){
          print("THIS HAS BEEN CAUGHT");
        }
      });
  }


}