part of event_calendar;


class _ColorPicker extends StatefulWidget{
  _ColorPicker({Key? key}) : super(key: key);
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<_ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: globals.colorCollection.length - 1,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(index == _selectedColorIndex ? Icons.lens : Icons.trip_origin, color: globals.colorCollection[index]),
              title: Text(globals.colorNames[index]),
              onTap: () {setState(() {_selectedColorIndex = index;}); Navigator.pop(context);},
            );
            Future.delayed(Duration(milliseconds: 200), () {Navigator.pop(context);});
          },
        )
      )
    );
  }
}