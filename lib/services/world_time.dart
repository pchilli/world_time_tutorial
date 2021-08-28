import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {

  String location; //location name for the UI
  late String time; //the time in that location
  String flag; //url to an asset flag url
  String url; //location url for api endpoint
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try {
      http.Response response = await http.get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      String offset = data["utc_offset"].substring(1, 3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print("Caught error: $e");
      time = "Could not get time data";
    }
  }

}