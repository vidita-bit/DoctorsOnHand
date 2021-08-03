import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'base.dart' as base;
import 'user.dart';
import 'dart:core';
import 'dart:math';
import 'profile.dart';

class HomePage extends StatefulWidget{
  HomePage({Key? key, required this.context}) : super(key: key);
  BuildContext context;
  Map<String, String> icons = {};
  List<Function?> fxns = List.empty();
  List<String> keys = List.empty();
  List<String> values = List.empty();
  List<dynamic> downloadPaths = List.empty();
  int i = 0;
  int cols = 3;
  int rows = 5;
  double basePadding = 1/4;
  bool called = false;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  void initState() {
    //better way for this needed
    widget.fxns = [() {}, () {},() {}, () {Navigator.push(this.context, MaterialPageRoute(builder : (context) => ProfilePage()));},() {}, () {},() {}, () {}, () {}, () {}, () {}];
    globals.iconsDoc.get().then((d) {
      print(d.data());
      setState(() {
          var grid = d['Grid'];
          widget.cols = grid['Col'];
          widget.rows = grid['Row'];
          widget.basePadding = grid["lateralPadding"];
          Map<String, String> map = {};
          List<String>.from(d[globals.baseRole + " Names"]).forEach((item) => map[item] = d[globals.baseRole][item]);
          List<String> roles = UserProfile.getVerifiedRoles();
          print("yoohooo");
          roles.sort();
          print(roles);
          print(map);
          for (int i = 0; i < roles.length; i++) {
            print("boo");
            String role = roles[i];
            if (role != globals.baseRole){
              print("gone");
              print(role);
              try{
                List<String>.from(d[role + " Names"]).forEach((item) => map[item] = d[role][item]);
              }
              catch (e){
                print("caught");
                // print(e);
              }
              print("bad");
              }
            }  
            print(map);
            widget.icons = map;
            widget.keys = widget.icons.keys.toList();
            widget.values = widget.icons.values.toList();
          });
    });
    
  }
    
  @override
  Widget build(BuildContext context){
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(globals.background),
            fit: BoxFit.cover,
          ),
        ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  base.BaseLogo(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  for (widget.i = 0; widget.i < widget.keys.length;) buildRow(widget.i),
                  
                ]
              )
            )
          )
        );
  }
 
  Widget buildRow(index){
    int end = index + widget.cols;
    end = min(end,widget.values.length);
    var sizedWidth = widget.basePadding + ((1 - ((1/widget.cols) * (end - index)))/2);
    widget.i += widget.cols;
    return base.BaseRow(index: index, keys: widget.keys.sublist(index, end), values: widget.values.sublist(index, end), fxns: widget.fxns.sublist(index, end), cols: widget.cols, rows: widget.rows, sizedWidth: sizedWidth);
  }

  bool? done(){
    return widget.downloadPaths.length == widget.values.length ? true : null;
  }
}

