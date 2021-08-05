
class Doctor{
  String? workEmail;
  String? workNum;
  String? workAddress;
  String? specialty;
 
  doctorCreate(String? mail, String? number, String? addy, String? spec){
    setWorkEmail(mail);
    setWorkNum(number);
    setWorkAddress(addy);
    setSpecialty(spec);
  }

  Doctor(var map){
    doctorCreate(map['workEmail'],map['workNumber'],map['workAddress'],map['specialty']);
  }

  void setWorkEmail(String? email){
    workEmail = email;
  }

  void setWorkNum(String? number){
    workNum = number;
  }

  void setWorkAddress(String? addy){
    workAddress = addy;
  }

  void setSpecialty(String? spec){
    specialty = spec;
  }

  String? getWorkEmail(){
    return workEmail;
  }

  String? getWorkNum(){
    return workNum;
  }

  String? getWorkAddress(){
    return workAddress;
  }

  String? getSpecialty(){
    return specialty;
  }
  List<dynamic> getList(){
    return [workEmail,workNum,workAddress,specialty];
  }
  bool canList(){
    bool listable = true;
    List<dynamic> items = getList();
    for (int i = 0; i < items.length; i++){
      print(items[i]);
      if (items[i] == null){
        listable = false;
      }
    }
    return listable;
  }

  Map<String,dynamic> toMap(Map<String,dynamic> map){
    print("BABDBABABA");
    map.addAll({"workEmail": getWorkEmail(), "workNum": getWorkNum(), "workAddress": getWorkAddress(), "specialty": getSpecialty()});
    print(map);
    return map;
  }
  
}