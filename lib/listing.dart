import 'package:doctorsonhand/displayCalendar.dart';

import 'doctor.dart';
import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'dart:math';
import 'base.dart' as base;
import 'calendar.dart';

class DocListing extends StatefulWidget {
  DocListing({Key? key, required this.doc}) : super(key: key);
  Doctor doc;
  List<IconData> icons = [];
  List<Function> fxns = [];

  @override
  _DocListingState createState() => _DocListingState();
}

class _DocListingState extends State<DocListing> {
  @override
  void initState() {
    print(widget.doc.getAppts(null));
    widget.icons = [Icons.phone, Icons.email, Icons.location_pin];
    widget.fxns = [
      widget.doc.getWorkNum,
      widget.doc.getWorkEmail,
      widget.doc.getWorkAddress
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(globals.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: globals.createPic(
            widget.doc.getImageAdd(),
            widget.doc.getFName(),
            widget.doc.getLName(),
            context,
          ),
          elevation: 0,
          title: Text(
            widget.doc.getFName() + " " + widget.doc.getLName(),
            style: TextStyle(
              color: globals.textColor,
              fontWeight: FontWeight.bold,
              fontSize: globals.chosenFontSize * 3,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Calendar(),
        ),
        // ListView(
        //   scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        //   children: <Widget>[
        //     Align(
        //       alignment: Alignment.topLeft,
        //       child: BackButton(
        //         color: Colors.white,
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ),
        //     Row(
        //       children: <Widget>[
        //         globals.createPic(widget.doc.getImageAdd(),
        //             widget.doc.getFName(), widget.doc.getLName(), context),
        //         SizedBox(width: MediaQuery.of(context).size.width * 0.3),
        //         Expanded(
        //           child: IntrinsicHeight(
        //             child: Column(children: <Widget>[
        //               Text(
        //                 widget.doc.getFName() + " " + widget.doc.getLName(),
        //                 style: TextStyle(
        //                   color: globals.textColor,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: globals.chosenFontSize * 4,
        //                 ),
        //               ),
        //               Text(
        //                 widget.doc.getSpecialty()!,
        //                 style: TextStyle(
        //                   color: globals.textColor,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: globals.chosenFontSize * 3,
        //                 ),
        //               ),
        //             ]),
        //           ),
        //         ),
        //       ],
        //     ),
        //     Expanded(
        //       child: IntrinsicHeight(
        //         //height: 500,
        //         child: Column(children: <Widget>[
        //           for (int i = 0; i < widget.fxns.length; i++)
        //             Row(children: <Widget>[
        //               SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        //               Icon(widget.icons[i],
        //                   color: globals.textColor,
        //                   size: globals.chosenFontSize * 1.25),
        //               SizedBox(
        //                   width: MediaQuery.of(context).size.width * 0.005),
        //               Text(
        //                 widget.fxns[i]()!,
        //                 style: TextStyle(
        //                   color: globals.textColor,
        //                   fontSize: globals.chosenFontSize * 1.25,
        //                 ),
        //               )
        //             ]),
        //         ]),
        //       ),
        //     ),
        //     SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        //     Calendar(),
        //     // EventCalendar(user: widget.doc, doc: widget.doc, embed: false, enabled: false, nullAppts: true),
        //     SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        //   ],
        // ),
      ),
    );
  }
}
