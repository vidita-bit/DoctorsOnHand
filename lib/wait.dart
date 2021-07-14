import 'globals.dart' as globals;
import 'package:flutter/material.dart';

class WaitWidget extends StatefulWidget {
  WaitWidget({Key? key, required this.dst, required this.obj}) : super(key: key);
  final Widget dst;
  final globals.Wrapper obj;
  @override
  _WaitWidgetState createState() => _WaitWidgetState();
}

class _WaitWidgetState extends State<WaitWidget> {


  @override
  Widget build(BuildContext context){
    while (widget.obj.getItem() == null) return CircularProgressIndicator();
    return widget.dst;
  }

}