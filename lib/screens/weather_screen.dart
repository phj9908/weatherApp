import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart'; // 폰트
import 'package:intl/intl.dart'; // 자료형 변환
import 'package:timer_builder/timer_builder.dart';
import 'package:weather_app/model/model.dart'; // 현재 시간

class WeatherScreen extends StatefulWidget{

  final dynamic parseWeatherData;
  final dynamic parseAirData;

  WeatherScreen({this.parseWeatherData, this.parseAirData});   // 클래스 생성자 아규먼트에 날씨데이터 추가함으로써 다른 파일에서 이 화면으로 이동할때 날씨데이터 전달하도록 함

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  Model model = Model();
  Widget icon;
  String cityName='';
  int temp=0;
  String des='';
  Widget airIcon; // 대기질지수 aqi를 index값에 따라 Icon으로 표시
  Widget airState; // 대기질지수 aqi를 index값에 따라 텍스트로 표시
  var date = DateTime.now();
  double dust1; // 미세먼지
  double dust2; //초미세먼지 지수

  @override
  void initState() {  // weatherScreen 위젯이 나타나는 순간 parseWeatherData 전달받도록
  super.initState();
  updateData(widget.parseWeatherData,widget.parseAirData);
  }

  void updateData(dynamic weatherData, dynamic airData){

    double rawTemp=0.0;
          cityName = weatherData['name'];    // jsonDecode() 자료형이 dynamic임 , 예측할 수 없음, 그래서 var
          rawTemp = weatherData['main']['temp'];

          temp= rawTemp.round(); // 반올림

          int condition = weatherData['weather'][0]['id'];
          icon = model.getWeatherIcon(condition);

          des = weatherData['weather'][0]['description']; // 날씨에 대한 설명명

          dust1 = airData['list'][0]['components']['pm10'];
          dust2 = airData['list'][0]['components']['pm2_5'];


          int index = airData['list'][0]['main']['aqi'];
          icon = model.getWeatherIcon(condition);
          airIcon = model.getAireIcon(index);
          airState = model.getAirCondition(index);


  }

  String getSystemTime(){
    var now = DateTime.now();

    return DateFormat("h:mm a").format(now); // intl라이브러리의 함수, 데이터 자료형을 문자열로 출력
                                              // ("h:mm a") 의 a는 am,pm 표시
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true, // 이거 까지 지정해야 앱바 배경 안보임
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 아이콘만 보이게 배경색은 투명으로
        elevation: 0.0, // 불투명도 0.0
        leading: IconButton(  // 앱바의 좌측에 버튼 만들 때 leading
          icon: Icon(Icons.near_me),
          onPressed: (){ },
          iconSize: 30.0,
        ),
        actions: [ // 앱바의 우측에 버튼 만들 때 actions: []
          IconButton(
              icon: Icon(Icons.location_searching),
              onPressed: (){},
          iconSize: 30.0,)
        ],
        //title: Text(''),

      ),
      body: Container(
        child: Stack( // 위젯을 쌓아올림
          children: [
            Image.asset(
              'image/background.jpg',
          fit: BoxFit.cover, // 화면에 다 채워지게
              width:double.infinity, 
              height: double.infinity, // 이거 까지 설정해야 다 채워짐
            ),
            Container(
              padding: EdgeInsets.all(20), // 텍스트가 모서리로부터 간격을 두게끔
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 위젯간에 간격 적절히 배치
                children: [
                  Expanded( // 위젯이 차지할 수있는 공간 최대한 차지하겠다
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽에 정렬하겠다
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽에 정렬하겠다
                          children: [
                            SizedBox(
                              height: 150.0,
                            ),
                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                    (Duration(minutes: 1)), // 보여지는 시간 단위, 1분 간격으로 지정
                                  builder: (context){
                                  print('$getSystemTime()}');
                                  return Text(
                                    '${getSystemTime()}',
                                    style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color: Colors.white
                                    )
                                  );
                                  },
                                ),
                                Text(
                                  DateFormat(' - EEEE, ').format(date), // 요일
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white
                                  ),
                                ),
                                Text(
                                  DateFormat(' d  MMM.  yyy').format(date), // 일 월 년
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp\u2103', // '\u2103' : 도씨 표시
                              style: GoogleFonts.lato(
                                  fontSize: 85.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white
                              ),
                            ),
                            Row(
                              children: [
                                icon, // svg형식 이미지 가져오기
                                Text(
                                  '$des',
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children:[
                               Text(
                                'AQI(대기질지수)',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),

                             airIcon,
                              SizedBox(
                                height: 10.0,
                              ),
                              airState,
                            ]
                            ),
                          Column(
                              children:[
                                Text(
                                  '미세먼지',
                                  style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                Text(
                                  '$dust1',
                                  style: GoogleFonts.lato(
                                    fontSize: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '㎍/m3',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ]
                          ),
                          Column(
                              children:[
                                Text(
                                  '초미세먼지',
                                  style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                Text(
                                  '$dust2',
                                  style: GoogleFonts.lato(
                                    fontSize: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '㎍/m3',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ]
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),


            ),

          ],
        ),
      ),
    );
  }
}