import 'package:flutter/material.dart';

class AreaButton extends StatelessWidget {
  const AreaButton({
    super.key,
    /*
    String number
    Color_Text
    Boolean sw; //opened or closed
    final Function myButtonTap;
    */
    required this.myButtonTap,
    required this.textNum,
    required this.color,
    required this.radius,
  });
  final String textNum;
  final Color color;
  final double radius;
  final Function myButtonTap;
  
  const AreaButton.opeButton({
    super.key,
    required this.textNum,
    required this.myButtonTap,
    this.color = Colors.blueAccent,
    this.radius = 100,
  });

  const AreaButton.numButton({
    super.key,
    required this.textNum,
    required this.myButtonTap,
    this.color = Colors.deepPurple,
    this.radius = 18,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 65,
      child: ElevatedButton(
        onPressed: () {
          myButtonTap();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Text(
          textNum,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}