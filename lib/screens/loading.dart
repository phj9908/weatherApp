
import 'dart:convert';
import 'package:http/http.dart' as http; // 다른개발자가 리뷰할 때 가독성을 위해
import 'package:flutter/material.dart';

import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';

// 날씨 API 사이트 : https://openweathermap.org/current , API 카테고리 클릭
const apikey = 'df5772bfcee8783a142c636fdea8f392'; // API사이트에 가입하고 얻은 api key

class Loading extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  double latitude3;
  double longitude3;

  @override
  void initState() {  // 위젯 생성주기 이용: 떄 바로 위치권한 허용하도록
    super.initState();
    getLocation();
  }

  void getLocation() async{ // API의 read me 참고하여, 현재 위치정보에 접근하는 메서드 생성성

    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();

    latitude3=myLocation.latitude2;
    longitude3=myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apikey');  // 사이트 참고하여 변수 삽입, 맨앞에 https://
      //섭씨 아닌 화씨 나와서 그것도 API제공 사이트 가서 Units of measurement카테고리 참고했음

    var weatherData= await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder: (context){   // WeatherScreen으로 화면 이동
      return WeatherScreen(
        parseWeatherData: weatherData,
        parseAirData: airData);   // weatherScreen페이지에 weatherData 전달
    }
    ));
}

  // //refactoring Before
  //
  // void fetchData() async{   // url 접속
  //
  //   http.Response response = await http.get('https://samples.openweathermap.org/data/2.5/weather?'
  //       'q=London&appid=b1b15e88fa797225412429c1c50c122a1');
  //               // Response 객체는 Future타입이기에 await필요 , url의 모든 정보를 가져올 때 까지 기다리도록 해야함
  //               // http 버전 최신거는 에러뜸, 일단 0.12.2 쓰기
  //
  //  if(response.statusCode ==200) // 200은 접속 성공, 404는 실패
  //     {
  //       String jsonData = response.body;
  //
  //       var parsingData = jsonDecode(jsonData);
  //
  //       var name = parsingData['name'];    // jsonDecode() 자료형이 dynamic임 , 예측할 수 없음, 그래서 var
  //       print(name);
  //
  //       var description = parsingData['weather'][0]['description'];
  //       print(description);
  //
  //       var wind = parsingData['wind']['speed'];
  //       print(wind);
  //
  //       var cloud = parsingData['clouds']['all'];
  //       print(cloud);
  //
  //   } else throw Exception('Failed to load data...');
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          )
          ,onPressed: (){


          },
          child: Text(
            'Get my location',
          ),
        ),
      ),
    );
  }
}