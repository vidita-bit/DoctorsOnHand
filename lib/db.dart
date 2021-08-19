import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> updateDoc(var map, DocumentReference document) async {
  print("UPDATING");
  print(document);
  await document.update(map).catchError((error) => print("Document update failed $error"));
}

Future<void> createDoc(var map, DocumentReference document) async {
  await document.set(map).catchError((error) => print("Document creation failed $error"));
}