import 'base.dart' as base;
import 'globals.dart' as globals;
import 'doctorController.dart';
import 'package:flutter/material.dart';
import 'doctor.dart';
import 'dart:math';


class Listings extends StatefulWidget {
  Listings({Key? key}) : super(key: key);
  DoctorController controller = DoctorController();
  List<Doctor> docs = [];
  final Color randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  @override
  _ListingsState createState() => _ListingsState();
    
}

class _ListingsState extends State<Listings> {
  @override
  void initState(){
    widget.docs = widget.controller.getDocs();
  }

  Widget createPic(String? imageAdd, first, last){
    print("ehehehe");
    // print(widget.first[0]);
    return imageAdd == null ? Container(margin: EdgeInsets.all(0), height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.15, decoration: BoxDecoration(color: widget.randomColor == Colors.blue ? Colors.red : widget.randomColor, shape: BoxShape.circle), child: Center(child: Text((first[0] + last[0]).toUpperCase(), style: TextStyle(color: globals.textColor, fontSize: 40, fontWeight: FontWeight.bold))))
        : Container(margin: EdgeInsets.all(0), height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.15, decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(imageAdd))));
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
                              return GestureDetector(
                                onTap: () {
                                  print(index);
                                },
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Row(children: [
                                      createPic(doc.getImageAdd(),doc.getFName(),doc.getLName()),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                      Expanded(
                                          flex: 14,
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
                              // return ListTile(
                              //   leading: createPic(doc.getImageAdd(),doc.getFirst(),doc.getLast()),
                              //   title: Text(doc.getFirst() + " " + doc.getLast(),style: TextStyle(fontSize: globals.chosenFontSize * 2)),
                              //   tileColor: globals.textColor,
                              //   subtitle: Text(doc.getSpecialty()!, style: TextStyle(fontSize: globals.chosenFontSize * 2 - 2)),
                              //   isThreeLine: true,
                              // );
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
