import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


Future<DocumentSnapshot<Object?>> getDoc(DocumentReference document) async {
  return document.get();
}