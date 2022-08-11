//https://github.com/SyncfusionExamples/scheduling-events-flutter-calendar/blob/master/lib/color-picker.dart
library event_calendar;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import "package:flutter/scheduler.dart";
import 'globals.dart' as globals;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'base.dart' as base;
import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'doctor.dart';
//part 'example.dart';

@JsonSerializable(explicitToJson: true)
class BookingService {
  /// The generated code assumes these values exist in JSON.
  String? userId;
  String? doctorId;
  String? userName;
  String? docName;
  String? docSpeciality;
  String? description;
  int? slotDuration;
  int? servicePrice;
  DateTime? bookingStart;
  DateTime? bookingEnd;
  String? phoneNumber;
  String? location;

  BookingService({
    this.userId,
    this.doctorId,
    this.userName,
    this.docName,
    this.docSpeciality,
    this.description,
    this.slotDuration,
    this.servicePrice,
    this.bookingStart,
    this.bookingEnd,
    this.phoneNumber,
    this.location,
  });

  /// Connect the generated [_$SportBookingFromJson] function to the `fromJson`
  /// factory.
  // factory SportBooking.fromJson(Map<String, dynamic> json) => _$SportBookingFromJson(json);

  // /// Connect the generated [_$SportBookingToJson] function to the `toJson` method.
  // Map<String, dynamic> toJson() => _$SportBookingToJson(this);
  Map<String,dynamic> toMap(BookingService app) {
    var data = <String, dynamic>{};
    data['userId'] = app.userId;
    data['doctorId'] = app.doctorId;
    data['userName'] = app.userName;
    data['docName'] = app.docName;
    data['docSpeciality'] = app.docSpeciality;
    data['description'] = app.description;
    data['slotDuration'] = app.slotDuration;
    data['servicePrice'] = app.servicePrice;
    data['bookingStart'] = app.bookingStart;
    data['bookingEnd'] = app.bookingEnd;
    data['phoneNumber'] = app.phoneNumber;
    data['location'] = app.location;

    return data;
  }

  fromMap(mapData, docId, rep) {
    BookingService app = BookingService();
    app.userId = mapData['userId'];
    app.doctorId = mapData['doctorId'];
    app.userName = mapData['userName'];
    app.docName = mapData['docName'];
    app.docSpeciality = mapData['docSpeciality'];
    app.description = mapData['description'];
    app.slotDuration = mapData['slotDuration'];
    app.servicePrice = mapData['servicePrice'];
    app.bookingStart = mapData['bookingStart'];
    app.bookingEnd = mapData['bookingEnd'];
    app.phoneNumber = mapData['phoneNumber'];
    app.location = mapData['location'];

    return app;
  }
}


// int _selectedColorIndex = 0;

// late DataSource _events;
// Meeting? _selectedAppointment;
// late DateTime _startDate;
// late TimeOfDay _startTime;
// late DateTime _endDate;
// late TimeOfDay _endTime;
// Map<String, dynamic>? _user;
// bool _inPerson = false;
// bool _chosenInPerson = false;
// bool _onCall = false;
// String _title = '';
// String _headerFormat = 'MMMM yy';
// String _notes = '';

// class EventCalendar extends StatefulWidget {
//   EventCalendar(
//       {Key? key,
//       required this.nullAppts,
//       required this.user,
//       this.doc,
//       this.embed = true,
//       this.enabled = true})
//       : super(key: key);
//   UserProfile user;
//   bool nullAppts;
//   Doctor? doc;
//   bool embed;
//   bool enabled;
//   @override
//   EventCalendarState createState() => EventCalendarState();
//   static List<Meeting> getAppts() {
//     return _events.getAppointments();
//   }
// }

// class EventCalendarState extends State<EventCalendar> {
//   // EventCalendarState();
//   CalendarView _calendarView = CalendarView.month;
//   late List<Meeting> appointments;

//   @override
//   void initState() {
//     appointments = widget.user.getAppts(widget.nullAppts);
//     _events = DataSource(appointments: appointments);
//     _selectedAppointment = null;
//     _selectedColorIndex = 0;
//     _title = '';
//     _notes = '';

//     super.initState();
//   }

//   Widget embed() {
//     if (widget.embed) {
//       return Column(children: <Widget>[
//         Align(
//             alignment: Alignment.topLeft,
//             child: BackButton(
//                 color: Colors.white,
//                 onPressed: () {
//                   widget.user
//                       .saveAppts(_events.getAppointments(), widget.nullAppts);
//                   Navigator.pop(context);
//                 })),
//         base.BaseLogo(),
//       ]);
//     }
//     return Container();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       embed(),
//       SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//       Center(
//           child: Container(
//               width: MediaQuery.of(context).size.width * 0.75,
//               height: MediaQuery.of(context).size.height * 0.75,
//               child: Scaffold(
//                   resizeToAvoidBottomInset: false,
//                   body: Padding(
//                       padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
//                       child: getEventCalendar(
//                           _calendarView, _events, onCalendarTapped)))))
//     ]);
//   }

//   SfCalendar getEventCalendar(
//       CalendarView _calendarView,
//       CalendarDataSource _calendarDataSource,
//       CalendarTapCallback calendarTapCallback) {
//     var now = DateTime.now();
//     return SfCalendar(
//         minDate: DateTime(now.year - 1, now.month, now.day, 0, 0, 0),
//         maxDate: DateTime(now.year + 1, now.month, now.day, 0, 0, 0),
//         view: _calendarView,
//         showDatePickerButton: true,
//         headerDateFormat: _headerFormat,
//         allowedViews: [
//           CalendarView.day,
//           CalendarView.week,
//           CalendarView.workWeek,
//           CalendarView.month,
//           CalendarView.timelineDay,
//           CalendarView.timelineWeek,
//           CalendarView.timelineWorkWeek,
//           CalendarView.timelineMonth,
//           CalendarView.schedule
//         ],
//         dataSource: _calendarDataSource,
//         onTap: calendarTapCallback,
//         onViewChanged: viewChanged,
//         initialDisplayDate: DateTime(DateTime.now().year, DateTime.now().month,
//             DateTime.now().day, 0, 0, 0),
//         monthViewSettings: MonthViewSettings(
//             appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
//         timeSlotViewSettings: TimeSlotViewSettings(
//             minimumAppointmentDuration: Duration(minutes: 10)));
//   }

//   void viewChanged(ViewChangedDetails viewChangedDetails) {
//     if (_calendarView == CalendarView.day) {
//       _headerFormat = 'yyy MMM';
//     } else if (_calendarView == CalendarView.week ||
//         _calendarView == CalendarView.workWeek ||
//         _calendarView == CalendarView.timelineDay ||
//         _calendarView == CalendarView.timelineMonth) {
//       _headerFormat = 'MMM yyy';
//     } else if (_calendarView == CalendarView.month) {
//       _headerFormat = 'MMMM yy';
//     } else if (_calendarView == CalendarView.timelineWeek ||
//         _calendarView == CalendarView.timelineWorkWeek) {
//       _headerFormat = 'MMM yy';
//     } else {
//       _headerFormat = 'yyy';
//     }
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(() {});
//     });
//   }

//   void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
//     if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
//         calendarTapDetails.targetElement != CalendarElement.appointment) {
//       return;
//     }
//     if (!widget.enabled &&
//         calendarTapDetails.targetElement != CalendarElement.appointment) {
//       return;
//     }
//     print("LOVE");
//     print(!widget.enabled);

//     setState(() {
//       _selectedAppointment = null;
//       _selectedColorIndex = 0;
//       _title = '';
//       _notes = '';
//       if (_calendarView == CalendarView.month) {
//         _calendarView = CalendarView.day;
//       } else {
//         if (calendarTapDetails.appointments != null &&
//             calendarTapDetails.appointments!.length == 1) {
//           Meeting meetingDetails = calendarTapDetails.appointments![0];
//           _startDate = meetingDetails.from;
//           _endDate = meetingDetails.to;
//           _user = meetingDetails.user;
//           _selectedColorIndex =
//               globals.colorCollection.indexOf(meetingDetails.background);
//           _title = meetingDetails.eventName;
//           _notes = meetingDetails.description;
//           _inPerson = meetingDetails.inPerson;
//           print("if");
//           _chosenInPerson = meetingDetails.chosenInPerson;
//           _onCall = meetingDetails.onCall;
//           _selectedAppointment = meetingDetails;
//         } else {
//           DateTime date = calendarTapDetails.date!;
//           print("else");
//           _startDate = date;
//           _endDate = date.add(Duration(hours: 1));
//         }
//         _startTime =
//             TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
//         _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
//         Navigator.push<Widget>(
//           context,
//           MaterialPageRoute(
//               builder: (BuildContext context) => AppointmentEditor(
//                   doc: widget.doc,
//                   enabled: widget.enabled,
//                   nullAppts: widget.nullAppts)),
//         );
//       }
//     });
//   }
// }
