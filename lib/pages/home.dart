import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    //Set background
    String bgImage = data["isDaytime"] ? "day.png" : "night.png";

    //Set Scaffold/top-bar colour
    Color? bgColour = data["isDaytime"] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColour,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/$bgImage"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
              child: Column(
                children: [
                  IconButton(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, "/location");
                        setState(() {
                          data = {
                            "location": result["location"],
                            "flag": result["flag"],
                            "time": result["time"],
                            "isDaytime": result["isDaytime"],
                          };
                        });
                      },
                      icon: Icon(Icons.edit_location),
                      color: Colors.grey[300],
                      iconSize: 60.0,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data["location"],
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
