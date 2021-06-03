import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class First extends StatefulWidget{
  const First({Key key}):super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {

  static TextStyle textStyle = GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text(
        'Business',
        style: textStyle,

      ),
    );
  }
}