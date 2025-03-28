import 'package:flutter/material.dart';

class Forecast extends StatelessWidget {

  final String time;
  final String value;


  const Forecast({
    super.key,
    required this.time,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    width: 100,
    child: Card(
      elevation: 9,
      child: Container(
        padding: EdgeInsets.all(9),
        width: 100,
          child: Column(
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 2),
              Icon(
                Icons.cloud,
                size: 25,
              ),
              SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  fontSize: 11,
             
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}