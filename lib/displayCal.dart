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
import 'doctor.dart';
part 'colorPicker.dart';
part 'calendar.dart';



int _selectedColorIndex = 0;

late DataSource _events;
Meeting? _selectedAppointment;
late DateTime _startDate;
late TimeOfDay _startTime;
late DateTime _endDate;
late TimeOfDay _endTime;
bool _inPerson = false;
bool _onCall = false;
String _title = '';
String _headerFormat = 'MMMM yy';
String _notes = '';

class EventCalendar extends StatefulWidget {
  EventCalendar({Key? key, required this.doc}) : super(key: key);
  Doctor doc;
  @override
  EventCalendarState createState() => EventCalendarState();
}


class EventCalendarState extends State<EventCalendar> {
  // EventCalendarState();
  CalendarView _calendarView = CalendarView.month;
  late List<Meeting> appointments;

  @override 
  void initState(){
    appointments = widget.doc.getAppts();
    _events = DataSource(appointments: appointments);
    _selectedAppointment = null;
    _selectedColorIndex = 0;
    _title = '';
    _notes = '';

    
    super.initState();
  }

  @override 
  Widget build(BuildContext context){
    return Column(children:<Widget> [
    Align(alignment: Alignment.topLeft, child: BackButton(color: Colors.white, onPressed: () {
        widget.doc.saveAppts(_events.getAppointments());
        Navigator.pop(context);
      })),
    base.BaseLogo(), 
    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
    Center(child: Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: getEventCalendar(_calendarView, _events, onCalendarTapped)))))]);
  }
  

  SfCalendar getEventCalendar(CalendarView _calendarView, CalendarDataSource _calendarDataSource,CalendarTapCallback calendarTapCallback) {
    var now = DateTime.now();
    return SfCalendar(
        minDate: DateTime(now.year - 1, now.month, now.day, 0 , 0, 0),
        maxDate: DateTime(now.year + 1, now.month, now.day, 0 , 0, 0),
        view: _calendarView,
        showDatePickerButton: true,
        headerDateFormat: _headerFormat,
        allowedViews: [
          CalendarView.day,
          CalendarView.week,
          CalendarView.workWeek,
          CalendarView.month,
          CalendarView.timelineDay,
          CalendarView.timelineWeek,
          CalendarView.timelineWorkWeek,
          CalendarView.timelineMonth,
          CalendarView.schedule
        ],
        dataSource: _calendarDataSource,
        onTap: calendarTapCallback,
        onViewChanged: viewChanged,
        initialDisplayDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0, 0),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        timeSlotViewSettings: TimeSlotViewSettings(
            minimumAppointmentDuration:  Duration(minutes: 10)));
  }

 void viewChanged(ViewChangedDetails viewChangedDetails) {
  if (_calendarView == CalendarView.day) {
    _headerFormat = 'yyy MMM';
  } else if (_calendarView == CalendarView.week ||
      _calendarView == CalendarView.workWeek ||
     _calendarView == CalendarView.timelineDay ||
      _calendarView == CalendarView.timelineMonth) {
    _headerFormat = 'MMM yyy';
  } else if (_calendarView == CalendarView.month) {
    _headerFormat = 'MMMM yy';
  } else if (_calendarView == CalendarView.timelineWeek ||
      _calendarView== CalendarView.timelineWorkWeek) {
    _headerFormat = 'MMM yy';
  } else {
    _headerFormat = 'yyy';
  }
  SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
    setState(() {
 
      });
    });
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    setState(() {
      _selectedAppointment = null;
      _selectedColorIndex = 0;
      _title = '';
      _notes = '';
      if (_calendarView == CalendarView.month) {
        _calendarView = CalendarView.day;
      } else {
        if (calendarTapDetails.appointments != null && calendarTapDetails.appointments!.length == 1) {
          final Meeting meetingDetails = calendarTapDetails.appointments![0];
          _startDate = meetingDetails.from;
          _endDate = meetingDetails.to;
          _selectedColorIndex = globals.colorCollection.indexOf(meetingDetails.background);
          _title = meetingDetails.eventName == '(No title)' ? '' : meetingDetails.eventName;
          _notes = meetingDetails.description;
          _inPerson = meetingDetails.inPerson;
          _onCall = meetingDetails.onCall;
          _selectedAppointment = meetingDetails;
        } else {
          final DateTime date = calendarTapDetails.date!;
          _startDate = date;
          _endDate = date.add(Duration(hours: 1));
        }
        _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
        _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
        Navigator.push<Widget>(context,MaterialPageRoute(builder: (BuildContext context) => AppointmentEditor(doc: widget.doc)),
        );
      }
    });
  }

}
  