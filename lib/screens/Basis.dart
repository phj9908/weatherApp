import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'First.dart';
import 'Second.dart';
import 'weather_screen.dart';

class Basis extends StatefulWidget{
  // const Basis({Key key}):super(key: key);

  final dynamic basisWeatherData;
  final dynamic basisAirData;

  Basis({this.basisWeatherData, this.basisAirData});   // 클래스 생성자 아규먼트에 날씨데이터 추가함으로써 다른 파일에서 이 화면으로 이동할때 날씨데이터 전달하도록 함


  @override
  _BasisState createState() => _BasisState();
}

class _BasisState extends State<Basis> {

  static TextStyle textStyle = GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold);



  int _selectedIndex = 0; // 첫화면은 index=0인 화면으로
  final List<Widget> _children = [WeatherScreen(), First(), Second()]; // 페이지 수

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // no AppBar
      body: _children.elementAt(_selectedIndex), // index에 따라 페이지 바뀜
      // body: Container(
      //   child: Text(
      //     '${widget.basisWeatherData}',
      //     style: textStyle,
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(


        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white70, // 선택되면 흰색으로 바뀜

      ),
    );
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex =index;
    });
  }
}