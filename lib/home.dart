import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'globals.dart' as globals;
import 'base.dart' as base;
import 'user.dart';
import 'dart:core';
import 'dart:math';
import 'wait.dart';

class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super(key: key);
  Map<String, String> icons = {};
  final List<Function?> fxns = [() {}, () {},() {}, () {},() {}, () {},() {}];
  List<String> keys = List.empty();
  List<String> values = List.empty();
  List<dynamic> downloadPaths = List.empty();
  int i = 0;
  final int cols = 3;
  final int rows = 5;
  bool called = false;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  void initState() {
    globals.IconsDoc.get().then((d) {
      print(d.data());
      setState(() {
          Map<String, String> map = {};
          List<String>.from(d["Patient Names"]).forEach((item) => map[item] = d["Patient"][item]);
          String role = UserProfile.getRole();

         if (role != "Patient"){
              try{
                print((role + " Names"));
                print((role + " Names") == "Doctor Names");
                List<String>.from(d["Doctor Names"]).forEach((item) => map[item] = d["Doctor"][item]);
              }
              catch (e){
                print("caught");
                print(e);
              }
              print("bad");
          }   
          print(map);
          widget.icons = map;
          widget.keys = widget.icons.keys.toList();
          widget.values = widget.icons.values.toList();
        });
    });
    
    super.initState();
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
    print(widget.downloadPaths);
    print("hehee");
    print(widget.keys);
    end = min(end,widget.keys.length);
    var sizedWidth = ((1 - ((1/widget.cols) * (widget.keys.length % widget.cols)))/2);
    widget.i += widget.cols;
    return base.BaseRow(index: index, keys: widget.keys.sublist(index, end), values: widget.values.sublist(index, end), fxns: widget.fxns.sublist(index, end), cols: widget.cols, rows: widget.rows, sizedWidth: sizedWidth);
  }

  bool? done(){
    return widget.downloadPaths.length == widget.values.length ? true : null;
  }
}

