
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
 CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

  ///This is how can you get the reference to your data from the collection, and serialize the data with the help of the Firestore [withConverter]. This function would be in your repository.
  CollectionReference<BookingService> getBookingStream({required String placeId}) {
    return bookings.doc(placeId).collection('bookings').withConverter<BookingService>(
          fromFirestore: (snapshots, _) => BookingService.fromJson(snapshots.data()!),
          toFirestore: (snapshots, _) => snapshots.toJson(),
        );
  }

  ///How you actually get the stream of data from Firestore with the help of the previous function
  ///note that this query filters are for my data structure, you need to adjust it to your solution.
  Stream<dynamic>? getBookingStreamFirebase(
    {required DateTime end, required DateTime start}) {
       return 
                        getBookingStream(placeId: 'YOUR_DOC_ID')
                        .where('bookingStart', isGreaterThanOrEqualTo: start)
                        .where('bookingStart', isLessThanOrEqualTo: end)
                        .snapshots();
  }

  ///After you fetched the data from firestore, we only need to have a list of datetimes from the bookings:
//   List<DateTimeRange> convertStreamResultFirebase(
//     {required dynamic streamResult}) {
//     ///here you can parse the streamresult and convert to [List<DateTimeRange>]
//     ///Note that this is dynamic, so you need to know what properties are available on your result, in our case the [SportBooking] has bookingStart and bookingEnd property
//       List<DateTimeRange> converted = []
//       for (var i = 0; i < data.size; i++) {
//         final item = data.docs[i].data();
//         converted.add(DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
//       }
//   return converted;
// }

  ///This is how you upload data to Firestore
  Future<dynamic> uploadBookingFirebase(
    {required BookingService newBooking}) async {
    await bookings
        .doc()
        .collection('bookings')
        .add(newBooking.toJson())
        .then((value) => print("Booking Added"))
        .catchError((error) => print("Failed to add booking: $error"));
    }
  
