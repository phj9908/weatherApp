import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Second extends StatefulWidget{
  const Second({Key key}): super(key:key);


  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {

   static TextStyle textStyle = GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text(
        'School',
        style: textStyle,
      ),
    );
  }
}