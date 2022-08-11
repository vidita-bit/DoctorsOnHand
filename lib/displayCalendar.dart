import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsonhand/controllers/appointmentController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:booking_calendar/booking_calendar.dart';
// import 'calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final now = DateTime.now();
  late BookingService mockBooking;

  @override
  void initState() {
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBooking = BookingService(
      //slotDuration: 15,
      userId: FirebaseAuth.instance.currentUser!.uid,
      userName: FirebaseAuth.instance.currentUser!.displayName,
      bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
      bookingStart: DateTime(now.year, now.month, now.day, 8, 0),
      serviceDuration: 15, serviceName: 'Appointments',
    );
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  // Future<dynamic> uploadBookingMock(
  //     {required BookingService newBooking}) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   converted.add(DateTimeRange(
  //       start: newBooking.bookingStart, end: newBooking.bookingEnd));
  //   print('has been uploaded');
  // }

  Future<dynamic> uploadBookingFirebase(
      {required BookingService newBooking}) async {
    await bookings
        .doc(globals.auth.currentUser!.uid)
        .collection('bookings')
        .add(newBooking.toJson())
        .then((value) => print("Booking Added"))
        .catchError((error) => print("Failed to add booking: $error"));
  }

  List<DateTimeRange> converted = [];
  CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  ///This is how can you get the reference to your data from the collection, and serialize the data with the help of the Firestore [withConverter]. This function would be in your repository.
  CollectionReference<BookingService> getBookingStream(
      {required String placeId}) {
    return bookings
        .doc(globals.auth.currentUser!.uid)
        .collection('bookings')
        .withConverter<BookingService>(
          fromFirestore: (snapshots, _) =>
              BookingService.fromJson(snapshots.data()!),
          toFirestore: (snapshots, _) => snapshots.toJson(),
        );
  }

  ///How you actually get the stream of data from Firestore with the help of the previous function
  ///note that this query filters are for my data structure, you need to adjust it to your solution.
  Stream<dynamic>? getBookingStreamFirebase(
      {required DateTime end, required DateTime start}) {
    return getBookingStream(placeId: globals.auth.currentUser!.uid)
        .where('bookingStart', isGreaterThanOrEqualTo: start)
        .where('bookingStart', isLessThanOrEqualTo: end)
        .snapshots();
  }
//     List<DateTimeRange> convertStreamResultFirebase(
//     {required dynamic streamResult}) {
//     ///here you can parse the streamresult and convert to [List<DateTimeRange>]
//     ///Note that this is dynamic, so you need to know what properties are available on your result, in our case the [SportBooking] has bookingStart and bookingEnd property
//       List<DateTimeRange> converted = []
//       for (var i = 0; i <  data.size; i++) {
//         final item = data.docs[i].data();
//         converted.add(DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
//       }
//   return converted;
// }

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    DateTime first = now;
    DateTime second = now.add(
      const Duration(minutes: 55),
    );
    DateTime third = now.subtract(
      const Duration(minutes: 240),
    );
    DateTime fourth = now.subtract(
      const Duration(minutes: 500),
    );
    converted.add(
      DateTimeRange(
        start: first,
        end: now.add(
          const Duration(minutes: 30),
        ),
      ),
    );
    converted.add(
      DateTimeRange(
        start: second,
        end: second.add(
          const Duration(minutes: 23),
        ),
      ),
    );
    converted.add(
      DateTimeRange(
        start: third,
        end: third.add(
          const Duration(minutes: 15),
        ),
      ),
    );
    converted.add(
      DateTimeRange(
        start: fourth,
        end: fourth.add(
          const Duration(minutes: 50),
        ),
      ),
    );
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
        start: DateTime(now.year, now.month, now.day, 12, 0),
        end: DateTime(now.year, now.month, now.day, 13, 0),
      )
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
      child: Center(
        child: BookingCalendar(
          bookingService: mockBooking,
          convertStreamResultToDateTimeRanges: convertStreamResultMock,
          getBookingStream: getBookingStreamFirebase,
          uploadBooking: uploadBookingFirebase,
          pauseSlots: generatePauseSlots(),
          pauseSlotText: 'Vacation',
          hideBreakTime: false,
          loadingWidget: const Text('Fetching data...'),
          uploadingWidget: const CircularProgressIndicator(),
          locale: 'en',
        ),
      ),
    );
  }
}
