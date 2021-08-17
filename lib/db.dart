import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


void updateDoc(var map, DocumentReference document){
      document.update(map).catchError((error) => print("Document update failed $error"));
}

void createDoc(var map, DocumentReference document){
  document.set(map).catchError((error) => print("Document creation failed $error"));
}