import 'base.dart' as base;
import 'globals.dart' as globals;
import 'doctorController.dart';
import 'package:flutter/material.dart';
import 'doctor.dart';
import 'listing.dart';
import 'dart:math';


class Listings extends StatefulWidget {
  Listings({Key? key}) : super(key: key);
  List<Doctor> docs = [];
  DoctorController controller = DoctorController();
  @override
  _ListingsState createState() => _ListingsState();
    
}

class _ListingsState extends State<Listings> {
  @override
  void initState(){
    widget.docs = widget.controller.getDocs();
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
            body: Center(
              child: ListView(
                  children: <Widget>[
                      Align(alignment: Alignment.topLeft, child: BackButton(color: Colors.white, onPressed: () {Navigator.pop(context);})),
                      base.BaseLogo(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      Center(
                          child: Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ListView.builder(
                            itemCount: widget.docs.length,
                            itemBuilder: (context, index){
                              Doctor doc = widget.docs[index];
                              print("Jonnie walker");
                              print(doc.getUid());
                              return GestureDetector(
                                onTap: () {
                                  print(index);
                                  Navigator.push(context,MaterialPageRoute(builder : (context) => DocListing(doc: doc)));
                                },
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Row(children: [
                                      globals.createPic(doc.getImageAdd(),doc.getFName(),doc.getLName(), context),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                      Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(doc.getFName() + " " + doc.getLName(), style: TextStyle(fontSize: globals.chosenFontSize * 2, fontWeight: FontWeight.bold)),
                                                Text(doc.getSpecialty()!, style: TextStyle(color: Colors.grey[700], fontSize: globals.chosenFontSize * 2 - 10, fontWeight: FontWeight.bold)),
                                                Text(doc.getWorkAddress()!, style: TextStyle(fontSize: globals.chosenFontSize, fontWeight: FontWeight.bold)),      
                                              ],
                                            ),
                                          ),
                                        ),

                                  ]
                                  )
                              ));
                             
                            }
                          ),
                        ),
                      ),

                  ]
                )
            )
        )
      );
  }
}
