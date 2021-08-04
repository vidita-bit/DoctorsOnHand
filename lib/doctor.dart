
class DoctorProfile{
  String? workEmail;
  String? workNum;
  String? workAddress;
  String? specialty;
  List<dynamic> items = [workEmail,workNum,workAddress,specialty];
  void setWorkEmail(email){
    workEmail = email;
  }

  void setWorkNum(number){
    workNum = number;
  }

  void setWorkAddress(addy){
    workAddress = addy;
  }

  void setSpecialty(spec){
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

  bool canList(){
    bool listable = true;
    for (int i = 0; i < items.length; i++){
      if (items[i] == null){
        listable = false;
      }
    }
    return listable;
  }

  Map<String,dynamic> toMap(Map<String,dynamic> map){
    return  map.addAll({"workEmail": getWorkEmail(), "workNum": getWorkNum(), "workAddress": getWorkAddress(), "specialty": getSpecialty()});
  }
  
}