import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:flutter_typeahead/flutter_typeahead.dart';


// class BaseContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context){
//     return Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(globals.background),
//             fit: BoxFit.cover,
//           )
//         ),
//     );
//   }
// }

class BaseDropDown extends StatefulWidget {
  BaseDropDown({Key? key, this.fieldName, required this.text, this.document, this.dropKey, required this.fxn, this.mode = AutovalidateMode.onUserInteraction}) : super(key: key);
  String? fieldName;
  List<String> text;
  final Function fxn;
  final AutovalidateMode mode;
  var document;
  var dropKey;
  BaseDropDownState state = BaseDropDownState();
  @override
  BaseDropDownState createState() => state;
  

}
class BaseDropDownState extends State<BaseDropDown> {
  String dropDownValue = "";

  @override
  void initState() {
    print(widget.text);
    if (widget.document != null){
      widget.document.get().then((d) {
        setState(() {
          try{
            widget.text = List<String>.from(d[widget.fieldName]);
          }
          catch (e){
            print(e);
          }
        });
      });
    }

    print(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
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

class BaseLookAheadBar extends StatelessWidget {
  BaseLookAheadBar({Key? key, required this.itemIcon, required this.icon, required this.onChanged, this.initialValue = "", required this.offset, this.trailing = null, required this.hint, this.barKey = null}) : super(key: key);
  final double offset;
  final String initialValue;
  final Widget itemIcon;
  final Widget icon;
  final Widget? trailing;
  final String hint;
  var onChanged;
  var barKey;
  // final Function validate;
  //immediate showing and return immediate
  Widget build(BuildContext context){
    return Column(children: <Widget> [
      Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(globals.radius),
          image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(globals.textBackground),
          ),
        ),
        child: TypeAheadFormField(
        key: barKey,
        validator: (text) {},
        initialValue: initialValue,
        getImmediateSuggestions: false,
        textFieldConfiguration: TextFieldConfiguration(
          cursorColor: globals.textColor,
          autofocus: false,
          style: TextStyle(
            color: globals.textColor,
            fontFamily: globals.font,
            fontSize: globals.chosenFontSize,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: globals.textColor, fontSize: globals.chosenFontSize),
            border: InputBorder.none,
            suffixIcon: trailing,
            prefixIcon: icon,
          )
        ),
        suggestionsCallback: (pattern)  {
          return onChanged(pattern);
        },
        itemBuilder: (context, suggestion) {
          
          print(suggestion);
          return ListTile(
            leading: itemIcon,
            title: Text("x"),
            subtitle: Text("subtitle"),
          );
        },
        onSuggestionSelected: (suggestion) {
          print(suggestion);
        },
      )),
      SizedBox(height: MediaQuery.of(context).size.height * offset)]);

  }
}

class BaseBar extends StatelessWidget {
  BaseBar({Key? key, this.enabled = true, required this.offset, this.trailing = null, this.initialValue = "", this.mode = AutovalidateMode.onUserInteraction, required this.icon, required this.hint, required this.validate, this.barKey = null, this.obscure = false}) : super(key: key);
  final double offset;
  final String? initialValue;
  final String icon;
  final Widget? trailing;
  final String hint;
  final bool obscure;
  final bool enabled;
  final AutovalidateMode mode;
  var barKey;
  final Function validate;
  @override
  Widget build(BuildContext context){
    return Column(children: <Widget>[
      Container(
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
                enabled: enabled,
                initialValue: initialValue,
                key: barKey,
                autovalidateMode: mode,
                obscureText: obscure,
                style: TextStyle(color: globals.textColor, fontSize: globals.chosenFontSize),
                cursorColor: globals.textColor,
                validator: (text) => this.validate(text,barKey),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: globals.textColor, fontSize: globals.chosenFontSize),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  suffixIcon: trailing,
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
        )),
      SizedBox(height: MediaQuery.of(context).size.height * offset),


    ]);
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




class BaseRow extends StatefulWidget {
  BaseRow({Key? key, required this.padding, required this.index, required this.keys, required this.values, required this.fxns, required this.cols, required this.rows, required this.sizedWidth}) : super(key: key);
  final int index;
  final List<String> keys;
  final List<dynamic> values;
  var fxns;
  final int cols;
  final int rows;
  final double padding;
  int j = 0;
  var sizedWidth;
  @override
  _BaseRowState createState() => _BaseRowState();
}

class _BaseRowState extends State<BaseRow> {
  // @override
  // void initState{
    
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * (1/widget.rows), 
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          SizedBox(width: MediaQuery.of(context).size.width * (widget.sizedWidth), height: MediaQuery.of(context).size.height * (1/widget.rows)),
          for (widget.j = 0; widget.j < widget.keys.length; widget.j++) Expanded(child: Container(width: MediaQuery.of(context).size.width , height: MediaQuery.of(context).size.height * (1/widget.rows), child: RaisedButton(onPressed: widget.fxns[widget.j], color: Colors.transparent, child: Column(mainAxisSize: MainAxisSize.min, children: <Widget> [Expanded(flex: 5, child: Image.network(widget.values[widget.j])),Expanded(flex: 1, child: Text(widget.keys[widget.j], style: TextStyle(fontWeight: FontWeight.bold, color: globals.textColor)))])))),
          SizedBox(width: MediaQuery.of(context).size.width * (widget.sizedWidth) , height: MediaQuery.of(context).size.height * (1/widget.rows)),
          ]
        )
      );
  }
    
}



