import 'globals.dart' as globals;
import 'package:firebase_core/firebase_core.dart';
import 'doctor.dart';

class DoctorController{
  static final DoctorController controller = DoctorController._internal();
  static List<Doctor> docs = [];
  static bool obtained = false;
  factory DoctorController(){
    if (!obtained){
      obtained = true;
      setupDocs();
    }

    return controller;
  }

  DoctorController._internal();

  static Future<void> setupDocs() async {
    var snap = await globals.doctorIndexDoc.get();
    var data = snap[globals.hp];

    for (int i = 0; i < data.length; i++){
      var d = await globals.userCollection.doc(data[i]).get();
      docs.add(Doctor(d['email'], d['first'], d['last'], d['phone'], d['image'],List<String>.from(d['requests']), List<String>.from(d['addresses']), List<String>.from(d['verifiedRoles']), d["Appts"], d['workEmail'],d['workNum'], d['workAddress'], d['specialty']));
    }
  }

  List<Doctor> getDocs(){
    return docs;
  }

}