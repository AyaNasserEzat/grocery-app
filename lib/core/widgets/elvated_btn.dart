import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_colors.dart';

class ElvatedButon extends StatelessWidget {
  ElvatedButon({
    required this.text,
    required this.onPressed,
    super.key,
  });
  String text;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(150, 25),
        backgroundColor: AppColors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
      ),
    );
  }
}
