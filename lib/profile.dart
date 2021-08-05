import 'package:flutter/material.dart';
import 'base.dart' as base;
import 'globals.dart' as globals;
import 'user.dart';
import 'auth.dart' as auth;
import 'dart:math';
import 'dart:core';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'addressManager.dart';
import 'package:fluttertoast/fluttertoast.dart';

//change from doctor to health professional
//verified list of roles, if role unverified mention in red text underneath with footnote
//multiple roles
class ProfilePage extends StatefulWidget{
  ProfilePage({Key? key}) : super(key: key);
  List<String> possibleRoles = [];
  final String first = UserProfile.getFName();
  final String last = UserProfile.getLName();
  final String? num = UserProfile.getNum();
  final String email = UserProfile.getEmail();
  final List<String> addresses = UserProfile.getAddresses() + [""];
  final AddressManager manager = AddressManager();
  int numBars = 0;
  final Color randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  var image = null;
  var path = null;
  var returnedImage = null;
  String? imageAdd = UserProfile.getImageAdd();


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{

  @override
  void initState(){
      print("INITI");
      print(widget.imageAdd);
      if (widget.imageAdd != null){
        widget.image = NetworkImage(widget.imageAdd!);
      }
      globals.rolesDoc.get().then((d) {
        List<String> tmp = [];
        List<String> verified = UserProfile.getVerifiedRoles();
        if (verified.length == 0){
          verified.add(globals.baseRole);
        }
        verified.forEach((role) {
          try{
            tmp += List<String>.from(d[role + " Ranks"]);
          }
          catch (e){
            print(e);
          }
        });
        Set<String> set = tmp.toSet();
        List<String> finalRoles = set.difference(verified.toSet()).toList();
        setState(() {
            widget.possibleRoles = ((finalRoles.length == 1 && finalRoles.contains("")) ? [] : finalRoles);
            widget.numBars = widget.addresses.length;
          });
    });
    super.initState();
  }

  Widget bar(String address, int i){
    // bool add = false;
    // Icon icon = Icon(Icons.remove, color: globals.textColor);
    // if (i  == (widget.addresses.length - 1)){
    //   icon = Icon(Icons.add, color: globals.textColor);
    //   add = true;
    // }
    // Widget trailing = GestureDetector(onTap: () {

    // },child: Container(width: MediaQuery.of(context).size.width * 0.01, height: MediaQuery.of(context).size.height * 0.01, decoration: BoxDecoration(color: add ? Colors.green : Colors.red, borderRadius: BorderRadius.circular(20)), child: icon));

    return base.BaseBar(offset: 0.02, initialValue: address, icon: globals.address, hint: "Enter Home Address", validate: () {}, barKey: widget.manager.addKey(i));
    // return base.BaseLookAheadBar(offset: 0.02, itemIcon: Icon(Icons.location_pin, color: Colors.black), barKey: widget.manager.addKey(i), initialValue: address, trailing: trailing, icon: Icon(Icons.location_pin, color: Colors.white), hint: "Enter Address", onChanged: (text) async {
    //   // String key = "AIzaSyDs5qT4f9iPYwO6XfZjVMd8AhVZ5IoXTH8";
    //   // var googlePlace = GooglePlace(key,proxyUrl: kIsWeb
    //   // ? 'cors-anywhere.herokuapp.com' : null);
      
    //   // if (text.length != 0){
    //   //   var r =  await googlePlace.autocomplete.get(text);
    //   //   print(text);
    //   //   print(r);
    //   //   // print(r!.predictions!.map((p)=> print(p.description)));
    //   //   // print(r!.status);
    //   // }
  
    // });

}

 
  @override
  Widget build(BuildContext context){
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(globals.background),
            fit: BoxFit.cover,
          )
        ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView(
                  children: <Widget>[Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(alignment: Alignment.topLeft, child: BackButton(color: Colors.white, onPressed: () {
                        Navigator.pop(context);
                          print(globals.fNameProfKey.currentState);
                          String email = globals.emailProfKey.currentState!.value;
                          String first = globals.fNameProfKey.currentState!.value;
                          String last = globals.lNameProfKey.currentState!.value;
                          String number = globals.phoneProfKey.currentState!.value;
                          List<GlobalKey<FormFieldState>> keys = widget.manager.getKeys();
                          List<String> locs = [];
                          
                          for (int i = 0; i < keys.length; i++){
                            String a = keys[i].currentState!.value;
                            if (a.length != 0){
                              locs.add(a);
                            }
                          }
                          UserProfile.profileUpdate(email,first,last,number,widget.returnedImage,locs);
                        })),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.15, child: Row(children: <Widget> [
                        Stack(children: <Widget>[
                          createPic(),
                          Positioned(left: MediaQuery.of(context).size.width * 0.085, bottom: MediaQuery.of(context).size.height * 0.0001, child: GestureDetector(onTap: () async {
                            if (widget.image != null){
                              UserProfile.setChanged(true);
                              setState(() {widget.image = widget.returnedImage = null;});
                            }
                          }, child: Container(padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(100)), child: Icon(Icons.delete, color: globals.textColor)))),
                          Positioned(left: MediaQuery.of(context).size.width * 0.09, bottom: MediaQuery.of(context).size.height * 0.1, child: GestureDetector(onTap: () async {
                            var image = await ImagePicker().getImage(source: ImageSource.gallery);
                            if (image != null){
                              UserProfile.setChanged(true);
                              image.readAsBytes().then(
                                (data) {
                                  dynamic loadedImage = NetworkImage(image.path);
                                  if (!kIsWeb){
                                    loadedImage = FileImage(File(image.path));
                                  }
                              
                                  setState(() {
                                    widget.returnedImage = data;
                                    widget.image = loadedImage;
                                  });
                              });
                           }}, child: Container(padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(100)), child: Icon(Icons.edit, color: globals.textColor)))),
                        ]),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                        base.BaseLogo()])),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      base.BaseText(text: "BASIC INFORMATION"),
                      Divider(height: MediaQuery.of(context).size.height * 0.01, thickness: MediaQuery.of(context).size.height * 0.0015, color: globals.textColor, indent: MediaQuery.of(context).size.width * 0.05, endIndent: MediaQuery.of(context).size.width * 0.05),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      createDrop(),
                      base.BaseBar(offset: 0.02, enabled: false, initialValue: widget.email, trailing: GestureDetector(onTap: () {
                          Fluttertoast.showToast(msg: "The registration email cannot be changed!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.white, textColor: Colors.red, fontSize: 16.0);
                      }, child: Icon(Icons.lock, color: Colors.white)), icon: globals.email, hint: globals.emailHint, validate: auth.emailError, barKey: globals.emailProfKey),
                      base.BaseBar(offset: 0.02, initialValue: widget.num, icon: "photos/phone.png", hint: "Phone Number", validate: auth.phoneError, barKey: globals.phoneProfKey),
                      base.BaseBar(offset: 0.02, initialValue: widget.first, icon: "photos/name.png", hint: "First Name", validate: auth.nameError, barKey: globals.fNameProfKey),
                      base.BaseBar(offset: 0.02, initialValue: widget.last, icon: "photos/name.png", hint: "Last Name",validate: auth.nameError, barKey: globals.lNameProfKey),
                      for (int i = 0; i < widget.numBars; i++) bar(widget.addresses[i], i),
           
              ]
            )]
          )
        )
      );
  }

  Widget createDrop(){
    if (widget.possibleRoles.length == 0){
      return Container();
    }
    return Container(width: MediaQuery.of(context).size.width * 0.25, height: MediaQuery.of(context).size.width * 0.05, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [
      Expanded(child: Text("I am also a", style: TextStyle(color: globals.textColor, fontSize: globals.chosenFontSize))),
      Expanded(child: base.BaseDropDown(text: widget.possibleRoles == null ? [] : widget.possibleRoles, fxn: () {},dropKey: globals.roleProfKey, mode: AutovalidateMode.disabled)),
      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
      Expanded(child: base.BaseButton(text: "SUBMIT", primary: Colors.blue, secondary: globals.textColor, fontSize: globals.chosenFontSize * 0.75, fxn: () {UserProfile.sendRequest(globals.roleProfKey.currentState!.value);}))
    ]));
  }
  Widget createPic(){
    print("ehehehe");
    return widget.image == null ? Container(margin: EdgeInsets.all(0), height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.15, decoration: BoxDecoration(color: widget.randomColor == Colors.blue ? Colors.red : widget.randomColor, shape: BoxShape.circle), child: Center(child: Text((widget.first[0]+ widget.last[0]).toUpperCase(), style: TextStyle(color: globals.textColor, fontSize: 40, fontWeight: FontWeight.bold))))
    : Container(margin: EdgeInsets.all(0), height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.15, decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.fill, image: widget.image)));
  }
}




//transaction, recently edited