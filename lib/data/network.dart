import 'dart:convert';
import 'package:http/http.dart' as http; // 다른개발자가 리뷰할 때 가독성을 위해

class Network{

  final String url;  // final :생성자로 입력받은 url 고정하기 위함
  final String url2;

  Network(this.url, this.url2);


  Future<dynamic> getJsonData() async{ // 파싱데이터의 자료형을 알수없어서 dynamic

    http.Response response = await http.get(url);
    // Response 객체는 Future타입이기에 await필요 , url의 모든 정보를 가져올 때 까지 기다리도록 해야함
    // http 버전 최신거는 에러뜸, 일단 0.12.2 쓰기

    if(response.statusCode ==200) // 200은 접속 성공, 404는 실패
        {
      String jsonData = response.body;

      var parsingData = jsonDecode(jsonData);  // 뒤에 카테고리 안달면 에러남
      return parsingData;
    }else throw Exception('Failed to load data...');

  }

  Future<dynamic> getAirData() async{ // 파싱데이터의 자료형을 알수없어서 dynamic

    http.Response response = await http.get(url2);
    // Response 객체는 Future타입이기에 await필요 , url의 모든 정보를 가져올 때 까지 기다리도록 해야함
    // http 버전 최신거는 에러뜸, 일단 0.12.2 쓰기

    if(response.statusCode ==200) // 200은 접속 성공, 404는 실패
        {
      String jsonData = response.body;

      var parsingData = jsonDecode(jsonData);  // 뒤에 카테고리 안달면 에러남
      return parsingData;
    }else throw Exception('Failed to load data...');

  }
}