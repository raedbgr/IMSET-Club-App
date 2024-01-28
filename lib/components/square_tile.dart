import 'package:flutter/material.dart';

class MySquareTile extends StatelessWidget {
  final String imagePath;

  const MySquareTile ({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade200,
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}