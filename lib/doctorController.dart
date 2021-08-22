import 'globals.dart' as globals;
import 'package:firebase_core/firebase_core.dart';
import 'doctor.dart';

class DoctorController{
  static final DoctorController controller = DoctorController._internal();
  static List<Doctor> docs = [];
  static Map<String, int> mapper = {};
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
      docs.add(Doctor(d["Appts"],d['email'], d['first'], d['last'], d['phone'], d['image'],List<String>.from(d['requests']), List<String>.from(d['addresses']), List<String>.from(d['verifiedRoles']), d['workEmail'],d['workNum'], d['workAddress'], d['specialty'], uid: data[i]));
      mapper[data[i]] = i;
    }
  }

  List<Doctor> getDocs(){
    return docs;
  }

  Future<void> updateDoc(String uid) async {
    int pos = mapper[uid]!;
    var d = await globals.userCollection.doc(uid).get();
    docs[pos] = Doctor(d["Appts"],d['email'], d['first'], d['last'], d['phone'], d['image'],List<String>.from(d['requests']), List<String>.from(d['addresses']), List<String>.from(d['verifiedRoles']), d['workEmail'],d['workNum'], d['workAddress'], d['specialty'], uid: uid);
  }

}