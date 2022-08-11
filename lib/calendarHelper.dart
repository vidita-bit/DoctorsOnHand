// part of event_calendar;

// /*
// Methods needed:

// 1) get all events from db, then store into list
// 2) Return all events
// 3) load all events into calendar
// 4) add event to calendar
// 5) Repeat event daily, weekly, monthly and every x days/weeks/months
// 6) Range of times with given increment

// */
import 'package:flutter/material.dart';
import 'globals.dart' as globals;


class Meeting {
  Meeting({required this.from, required this.inPerson, required this.chosenInPerson, required this.onCall, required this.to,this.background = Colors.green, this.eventName = '', this.description = '', this.user});
  final Map<String, dynamic>? user;
  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool inPerson;
  final bool onCall;
  final bool chosenInPerson;
  final String description;

  dynamic toJson(){
    return {"eventName": eventName, "from": from.toIso8601String(), "to": to.toIso8601String(), "color": globals.colorCollection.indexOf(background), "inPerson": inPerson, "chosenInPerson": chosenInPerson, "onCall": onCall, "description": description, "user": user};
  }
  
  static Meeting toMeeting(dynamic map){
    return Meeting(eventName: map["eventName"], from: DateTime.parse(map["from"]), to: DateTime.parse(map["to"]), background: globals.colorCollection[map["color"]], inPerson: map["inPerson"], chosenInPerson: map["chosenInPerson"], onCall: map["onCall"], description: map["description"], user: map["user"]);
  }
}

// class DataSource extends CalendarDataSource {
//   DataSource({required this.appointments});

//   final List<Meeting> appointments;

//   List<Meeting> getAppointments(){
//     return appointments;
//   }
//   @override
//   String getSubject(int index) => appointments[index].eventName;

//   @override
//   String getNotes(int index) => appointments[index].description;

//   @override
//   Color getColor(int index) => appointments[index].background;

//   @override
//   DateTime getStartTime(int index) => appointments[index].from;

//   @override
//   DateTime getEndTime(int index) => appointments[index].to;
// }



// class AppointmentEditor extends StatefulWidget{
//   AppointmentEditor({Key? key, this.doc, this.enabled = true, required this.nullAppts}) : super(key: key);
//   Doctor? doc;
//   bool? nullAppts;
//   bool enabled;
//   @override
//   _AppointmentEditorState createState() => _AppointmentEditorState();

// }
// class _AppointmentEditorState extends State<AppointmentEditor>{
  
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(getTitle()),
//           backgroundColor: globals.colorCollection[_selectedColorIndex],
//           leading: IconButton(icon: Icon(Icons.close, color: Colors.white), onPressed: () {
//             _user = null; 
//             _onCall = false;
//             _inPerson = false;
//             _chosenInPerson = false;
//             Navigator.pop(context);
//           }),
//           actions: <Widget>[
//             if (widget.enabled) IconButton(
//               padding: EdgeInsets.fromLTRB(5,0,5,0),
//               icon: Icon(Icons.done, color: Colors.white),
//               onPressed: () async {
//                 await onDone(context);
//               }
//             )
//           ],
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(5),
//           child: Stack(
//             children: <Widget>[
//               _getAppointmentEditor(context, enabled: widget.enabled)
//             ],
//           )
//         ),
//       floatingActionButton: !widget.enabled || _selectedAppointment == null ? Container() : FloatingActionButton(onPressed: (){
//         if (_selectedAppointment != null){
//           _events.appointments.removeAt(_events.appointments.indexOf(_selectedAppointment!));
//           _events.notifyListeners(CalendarDataSourceAction.remove,<Meeting>[]..add(_selectedAppointment!));
//           _selectedAppointment = null;
//           Navigator.pop(context);
//         }
//       },
//       child: Icon(Icons.delete_outline, color: Colors.white),
//       backgroundColor: Colors.red,
//       )
//     ),
//   );
    
//   }
//   String getTitle(){
//     return _title.isEmpty ? "New event" : "Event details";
//   }
//   Widget _getTitle({bool enabled = true}){
//     return ListTile(
//           contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 5),
//           leading: Text(""),
//           title: TextField(
//             enabled: enabled,
//             controller: TextEditingController(text: _title),
//             onChanged: (String value) {_title = value;},
//             keyboardType: TextInputType.multiline,
//             maxLines: null,
//             style: TextStyle(
//               fontSize: globals.chosenFontSize + 5,
//               color: Colors.black,
//               fontWeight: FontWeight.w400
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: enabled ? "Add Title" : globals.defaultTitle
//             ),
//         ),
//         );
//   }
//   Widget _getAppointmentEditor(BuildContext context, {bool enabled = true}){
    
//     return Container(
//       color: Colors.white,
//       child: ListView(
//         // padding: EdgeInsets.all(0),
//         children: <Widget>[
//           if (_user != null) addUserInfo(),
//           _getTitle(enabled: enabled),
//           Divider(height: 1, thickness: 1),
//           if (enabled) ListTile(
//             contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
//             leading: Icon(Icons.access_time, color: Colors.black54),
//             title: Row(children: <Widget>[
//               Expanded(child: Text("In person accepted")),
//               Expanded(child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Switch(
//                   value: _inPerson,
//                   onChanged: (bool value) {setState(() {_inPerson = value;});},
//                 )
//               )
//               ),
//             ])),
//           if (enabled) ListTile(
//             contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
//             leading: Icon(Icons.access_time, color: Colors.black54),
//             title: Row(children: <Widget>[
//               Expanded(child: Text("Calls accepted")),
//               Expanded(child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Switch(
//                   value: _onCall,
//                   onChanged: (bool value) {setState(() {_onCall = value;});},
//                 )
//               )
//               ),
//             ])),
            
//           ListTile(
//             contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
//             leading: Text(""),
//             title: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(flex: 7, child: GestureDetector(
//                   onTap: () async {
//                     if (enabled){
//                       var now = DateTime.now();
//                       final DateTime? date = await showDatePicker(
//                         context: context,
//                         initialDate: _startDate,
//                         firstDate: DateTime(now.year, now.month, now.day),
//                         lastDate: DateTime(now.year, now.month + 1, now.day)
//                         );
//                       if (date != null && date != _startDate){
//                         setState(() {
//                           final Duration difference = _endDate.difference(_startDate);
//                           _startDate = DateTime(date.year,date.month,date.day,_startTime.hour,_startTime.minute,0);
//                           _endDate = _startDate.add(difference);
//                           _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
//                         });
//                       }
//                     }
//                   },
//                   child: Text(DateFormat("EEE, MMM dd yyyy").format(_startDate), textAlign: TextAlign.left),
//                   )
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: GestureDetector(child: Text(
//                     DateFormat("hh:mm a").format(_startDate),
//                     textAlign: TextAlign.right,
//                     ),
//                   onTap: () async {
//                     if (enabled){
//                       final TimeOfDay? time = await showTimePicker(
//                         context: context,
//                         initialTime: TimeOfDay(
//                           hour: _startTime.hour,
//                           minute: _startTime.minute
//                         )
//                       );

//                       if (time != null && time != _startTime){
//                         setState(() {
//                           _startTime = time;
//                           final Duration difference = _endDate.difference(_startDate);
//                           _startDate = DateTime(_startDate.year,_startDate.month, _startDate.day, _startTime.hour, _startTime.minute,0);
//                           _endDate = _startDate.add(difference);
//                           _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
//                         });
//                       }
//                     }
//                   },
//                   ),
//                 ),
//               ]),
//           ),
//           ListTile(
//               contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
//               leading: Text(""),
//               title: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(flex: 7, child: GestureDetector(
//                     onTap: () async {
//                       if (enabled){
//                         var now = DateTime.now();
//                         final DateTime? date = await showDatePicker(
//                           context: context,
//                           initialDate: _endDate,
//                           firstDate: DateTime(now.year, now.month, now.day),
//                           lastDate: DateTime(now.year, now.month + 1, now.day)
//                           );
//                         if (date != null && date != _endDate){
//                           setState(() {
//                             final Duration difference = _endDate.difference(_startDate);
//                             _endDate = DateTime(date.year,date.month,date.day,_startTime.hour,_startTime.minute,0);
//                             if (_endDate.isBefore(_startDate)){
//                               _startDate = _endDate.subtract(difference);
//                               _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
//                             }
//                           });
//                         }
//                       }
//                     },
//                     child: Text(DateFormat("EEE, MMM dd yyyy").format(_endDate), textAlign: TextAlign.left),
//                     )
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: GestureDetector(child: Text(
//                       DateFormat("hh:mm a").format(_endDate),
//                       textAlign: TextAlign.right,
//                       ),
//                     onTap: () async {
//                       if (enabled){
//                         final TimeOfDay? time = await showTimePicker(
//                           context: context,
//                           initialTime: TimeOfDay(
//                             hour: _endTime.hour,
//                             minute: _endTime.minute
//                           )
//                         );

//                         if (time != null && time != _endTime){
//                           setState(() {
//                             _endTime = time;
//                             final Duration difference = _endDate.difference(_startDate);
//                             _endDate = DateTime(_endDate.year,_endDate.month, _endDate.day, _endTime.hour, _endTime.minute,0);
//                             if (_endDate.isBefore(_startDate)){
//                               _startDate = _endDate.subtract(difference);
//                               _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
//                             }
//                           });
//                         }
//                       }
//                     },
//                     ),
//                   ),
//                 ]),
//             ),  
//             if (enabled) ListTile(
//               contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
//               leading: Icon(Icons.lens, color: globals.colorCollection[_selectedColorIndex]),
//               title: Text(globals.colorNames[_selectedColorIndex]),
//               onTap: () {
//                 showDialog<Widget>(
//                   context: context,
//                   barrierDismissible: true,
//                   builder: (BuildContext context){
//                     return _ColorPicker();
//                   },
//                   ).then((value) => setState(() {}));
//               },
//             ),
//             Divider(height: 1, thickness: 1),
//             if (enabled == true || _notes.length != 0) ListTile(
//               contentPadding: EdgeInsets.all(5),
//               leading: Icon(Icons.subject, color: Colors.black87),
//               title: TextField(
//                 enabled: enabled,
//                 controller: TextEditingController(text: _notes),
//                 onChanged: (String value) {_notes = value;},
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 style: TextStyle(fontSize: globals.chosenFontSize, color: Colors.black87, fontWeight: FontWeight.w400),
//                 decoration: InputDecoration(border: InputBorder.none, hintText: "Add description")
//               )
//             ),
//             if (enabled == true || _notes.length != 0) Divider(height: 1, thickness: 1),
//             if (!enabled) ListTile(
//             contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
//             leading: Icon(Icons.access_time, color: Colors.red),
//             title: Row(children: <Widget>[
//               Expanded(child: Text("Is this meeting in person?", style: TextStyle(color: Colors.red, fontSize: globals.chosenFontSize))),
//               Expanded(child: Align(
//                 alignment: Alignment.centerRight,
//                 child: _user == null && _inPerson && _onCall ? base.BaseCheck(callback: (bool val) {_chosenInPerson = val;}, text:"", activeColor: globals.colorCollection[_selectedColorIndex], color: Colors.red) : Text(_chosenInPerson ? "YES " : "NO ", style: TextStyle(color: Colors.red)),
//               )
//               ),
//             ])),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.5),
//           if (!enabled && _user == null && widget.doc!.getUid() != globals.user.getUid()) base.BaseButton(text: "BOOK NOW", secondary: Colors.red, primary: globals.textColor, fxn: () async {
//             print(_chosenInPerson);
         
//             await onDone(context, user: {"owner": widget.doc!.getUid(), "ownerName": widget.doc!.getFName() + " " + widget.doc!.getLName(), "ownerEmail": widget.doc!.getWorkEmail(), "ownerNumber": widget.doc!.getWorkNum(), "ownerAddress": widget.doc!.getWorkAddress(),
//             "booker": globals.user.getUid(),  "bookerName": globals.user.getFName() + " " + globals.user.getLName(), "bookerEmail": globals.user.getEmail(), "bookerNumber": globals.user.getNum()});
//           }),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          
//       ])
//     );
//   }

//   Widget addUserInfo(){
//     List<IconData> icons = [Icons.person, Icons.email];
//     String person = "booker";
//     TextStyle style = TextStyle(color: Colors.black, fontSize: globals.chosenFontSize * 1.5, fontWeight: FontWeight.bold);
//     if (_user![person] == globals.user.getUid()){
//       person = "owner";
//     }
//     List<String> items = [_user![person + "Name"]!, _user![person + "Email"]!];
//     String?  number = _user![person + "Number"];   

//     if (number != null && number.length != 0){
//       icons.add(Icons.phone);
//       items.add(number);
//     }
//     if (person == "owner"){
//       icons.add(Icons.location_pin);
//       items.add(_user![person + "Address"]!);
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         for (int i = 0; i < items.length; i ++) 
//           Row(children: <Widget>[
//             Icon(icons[i], color: Colors.black, size: globals.chosenFontSize * 1.25), 
//             SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//             Text(items[i], style: TextStyle(color: Colors.black, fontSize: globals.chosenFontSize * 1.25))
//           ]),
//         Divider(height: 1, thickness: 1),
//       ]
//     );
//   }
//   Future<void> onDone(BuildContext context, {Map<String, dynamic>? user}) async {
//     final List<Meeting> meetings = [];
//     if (_selectedAppointment != null){
//       _events.appointments.removeAt(_events.appointments.indexOf(_selectedAppointment!));

//       _events.notifyListeners(CalendarDataSourceAction.remove,  <Meeting>[]..add(_selectedAppointment!));
//     }
//     Meeting meeting = Meeting(
//       from: _startDate,
//       to: _endDate,
//       background: globals.colorCollection[_selectedColorIndex],
//       description: _notes,
//       inPerson: _inPerson,
//       user: user,
//       chosenInPerson: _chosenInPerson,
//       onCall: _onCall,
//       eventName: _title == "" ? globals.defaultTitle : _title
//     );
//     meetings.add(meeting);

//     _events.appointments.add(meetings[0]);
//     _events.notifyListeners(CalendarDataSourceAction.add, meetings);
//     _selectedAppointment = null;
//     if (user != null){
//       globals.user.addAppt(meeting);
//       await globals.user.saveAppts(globals.user.getAppts(null),null);
//       print("JOON");
//       print(widget.doc!.getUid());
//       widget.doc!.saveAppts(_events.getAppointments(), widget.nullAppts);

//     }
//     Navigator.pop(context);
//   }
// }

