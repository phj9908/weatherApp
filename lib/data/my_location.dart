import 'package:geolocator/geolocator.dart';

class MyLocation{
  double latitude2;
  double longitude2;

  Future<void> getMyCurrentLocation() async{    // 다른파일에서 이함수를 쓸 때 await을 쓰고, 그럼 미래에 값을 받는 것이기에 future<> 쓰기
    try {
      Position position = await Geolocator.   // 여기서 await을 쓰기에 다른 파일에서 이 함수를 호출할때도 await이 앞에 있어야 됨
        getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation); // 위치정확도 high

      // print(position); // 위도 경도 한번에 출력할 때
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print(latitude2);
      print(longitude2);

    }
    catch(e){
      print('There was a problem with the internet connection ');
    }
  }
}