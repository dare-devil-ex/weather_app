import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/pages/Additional.dart';
import 'package:weather_app/pages/forecast.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

  double temp = 0;

  Future fetcher() async {
    try{
      final res = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=London&appid=d1845658f92b31c64bd94f06f7188c9c"));
      final data = jsonDecode(res.body);
      
      if (data["cod"] != "200") {
        throw "Bad request!";
      }

      setState(() {
        temp = data["list"][0]["main"]["temp"];
      });
      

      } catch(e) {
        throw "Error occured";
      }
    }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WEATHER APP",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            
          },
          icon: Icon(Icons.refresh))
        ],
      ),

      body: FutureBuilder(
        future: fetcher(),
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Box
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 13,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              "$temp°K",
                              style: TextStyle(
                                fontSize: 30,
                                letterSpacing: 0.9,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(
                              Icons.cloud,
                              size: 50,
                            ),
                            Text(
                              "Rain",
                              style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
        
              // Forecast
              Text(
                "Weather Forecast",
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Forecast(time: "19:01", value: "203"),
                    Forecast(time: "19:01", value: "203"),
                    Forecast(time: "19:01", value: "203"),
                    Forecast(time: "19:01", value: "203"),
                  ],
                ),
              ),
        
              SizedBox(height: 20),
        
              // Forecast
              Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              SizedBox(height: 15),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
        
                  // humidity
                  Additional(
                    icon: Icons.water_drop,
                    label: "Humidity",
                    value: "91",
                  ),
        
                  // wind speed
                  Additional(
                    icon: Icons.air,
                    label: "Wind speed",
                    value: "103.6",
                  ),
        
                  // pressure
                  Additional(
                    icon: Icons.beach_access,
                    label: "Pressure",
                    value: "1002",
                  )
        
                ],
              ),
             ],
          ),
        ),
      ),
    );
  }
}