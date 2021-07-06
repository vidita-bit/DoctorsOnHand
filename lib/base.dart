import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'db.dart';

class BaseContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(globals.background),
            fit: BoxFit.cover,
          )
        ),
    );
  }
}

class BaseDropDown extends StatefulWidget {
  BaseDropDown({Key? key, required this.document, this.dropKey = null, required this.fxn, this.mode = AutovalidateMode.onUserInteraction}) : super(key: key);
  List<String> text = List.empty();
  final Function fxn;
  final AutovalidateMode mode;
  final DocumentReference document;
  var dropKey;
  
  @override
  _BaseDropDownState createState() => _BaseDropDownState();

}
class _BaseDropDownState extends State<BaseDropDown> {
  @override
  void initState() {
    getDoc(widget.document).then((d) {
      setState(() {print(d.data());widget.text = List<String>.from(d['Roles']);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    String dropDownValue = "";
    return DropdownButtonFormField<String>(
      autovalidateMode: widget.mode,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white))),
      key: widget.dropKey,
      validator: (String? value) => widget.fxn(value,widget.dropKey),
      value: dropDownValue,
      style: TextStyle(fontWeight: FontWeight.bold),
      items: widget.text == null ? [] : widget.text.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value)
        );
      }).toList(),
      onChanged: (String? newVal) {setState(() {dropDownValue = newVal!;});},
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.white,
      selectedItemBuilder: (BuildContext context) {
          return widget.text.map<Widget>((item) {
            return Text(item,style: TextStyle(color: Colors.white));
                
          }).toList();
        },
    );
  }
}


class BaseText extends StatelessWidget {
  BaseText({Key? key, required this.text, this.weight = FontWeight.normal}) : super(key: key);
  final String text;
  final FontWeight weight;
  @override
  Widget build(BuildContext context){
    return Text(
      text,
      style: TextStyle(color: globals.textColor, fontSize: globals.chosenFontSize)
    );
  }
}

class BaseCheck extends StatefulWidget {
  BaseCheck({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  _BaseCheckState createState() => _BaseCheckState();
}

class _BaseCheckState extends State<BaseCheck> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context){
    return Theme(data: ThemeData(unselectedWidgetColor: globals.textColor), child: CheckboxListTile( 
      activeColor: Colors.pink[300],
      dense: true,
      title: Text(widget.text, style: TextStyle(color: globals.textColor, fontSize: globals.chosenFontSize)),
      value: isChecked,
      contentPadding: EdgeInsets.all(0),
      onChanged: (bool? newValue) {
        setState(() {isChecked = newValue;})
      ;}));
  }
}

class BaseBar extends StatelessWidget {
  BaseBar({Key? key, this.mode = AutovalidateMode.onUserInteraction, required this.icon, required this.hint, required this.validate, this.barKey = null, this.obscure = false}) : super(key: key);
  final String icon;
  final String hint;
  final bool obscure;
  final AutovalidateMode mode;
  var barKey;
  final Function validate;
  @override
  Widget build(BuildContext context){
    return Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(globals.radius),
          image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(globals.textBackground),
          ),
        ),
        child: TextFormField(
                key: barKey,
                autovalidateMode: mode,
                obscureText: obscure,
                style: TextStyle(color: globals.textColor, fontSize: 20),
                cursorColor: Colors.white,
                validator: (text) => this.validate(text,barKey),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: globals.textColor, fontSize: globals.chosenFontSize),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  prefixIcon: Transform.scale(scale: 1, child: Padding(
                      padding:EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02), 
                      child:Image(
                      image: AssetImage(icon),
                      width: MediaQuery.of(context).size.width * 0.03,
                      height: MediaQuery.of(context).size.height,
                      color: null,
                    )
                  )
                  )
                )
        )
    );
  }
}

class BaseLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(globals.logo),
        ),
      ),
    );
  }
}

class BaseButton extends StatelessWidget {
  BaseButton({Key? key, required this.text, required this.primary, required this.secondary, this.weight = FontWeight.normal, this.fontSize = 20, required this.fxn}) : super(key: key);
  final String text;
  final Color primary;
  final Color secondary;
  final FontWeight weight;
  final double fontSize;
  final Function fxn;
  @override
  Widget build(BuildContext context){
    return TextButton(
      style: TextButton.styleFrom(
        primary: primary,
        backgroundColor: secondary,
        textStyle: TextStyle(fontSize: fontSize, fontWeight: weight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(globals.radius/2)
        )
      ),
      onPressed: () => fxn(),
      child: Text(text),
    );
  }
}




