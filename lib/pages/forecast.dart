import 'package:flutter/material.dart';

class Forecast extends StatelessWidget {

  final String time;
  final String value;
  final IconData icon;


  const Forecast({
    super.key,
    required this.time,
    required this.value,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    width: 100,
    child: Card(
      elevation: 4.4,
      child: Container(
        padding: EdgeInsets.all(9),
        width: 100,
          child: Column(
            children: [
              Text(
                time,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 7),
              Icon(
                icon,
                size: 25,
              ),
              SizedBox(height: 7),
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