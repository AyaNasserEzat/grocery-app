import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  CustomBtn({
    required this.backgroundColor,
    required this.text,
    this.onPressed,
    super.key,
  });
  Color? backgroundColor;
  String text;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: const Size(350, 43),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 19),
      ),
    );
  }
}
