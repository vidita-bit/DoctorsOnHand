import 'globals.dart' as globals;
import 'package:flutter/material.dart';


class AddressManager {
  static final AddressManager manager = AddressManager._internal();
  static List<GlobalKey<FormFieldState>> _addKeys = [];
  static int _numKeys = 0;
  factory AddressManager(){
    return manager;
  }
  AddressManager._internal();
  GlobalKey<FormFieldState> addKey(int i){
    print(_addKeys);
    if ((i + 1) > _numKeys){
      GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();
      _addKeys.add(key);
      _numKeys++;
      return key;
    }

    return _addKeys[i];

  }


}