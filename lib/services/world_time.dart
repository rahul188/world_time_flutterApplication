import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;
  String time;
  String flag; //url to an assests of flage
  String url; //location url for api end point 
  bool isDayTime; //checking is there is day or night

  WorldTime({this.location,this.flag,this.url,this.isDayTime});

    Future<void> getTime() async {

    try{

    //make request
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    String dateTime = data['datetime'];
    String offsetHours = data['utc_offset'].toString().substring(1,3);
    String offsetMinutes = data['utc_offset'].toString().substring(4,6);
    
    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours:int.parse(offsetHours),minutes: int.parse(offsetMinutes)));
    time = now.toString();

    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);

    }
    catch(e)
    {
      print("caught error : $e");
      time = "somethig went wrong";
    }
  }
}

