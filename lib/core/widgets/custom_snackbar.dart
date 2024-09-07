import 'package:flutter/material.dart';

enum SnackBarType { error, success, info }

SnackBar customSnackBar({
  required String message,
  required SnackBarType type,
}) {
  Color? backgroundColor;
  Color textColor;
  IconData iconData;

  switch (type) {
    case SnackBarType.error:
      backgroundColor = Colors.red;
      textColor = Colors.white;
      iconData = Icons.error_outline;
      break;
    case SnackBarType.success:
      backgroundColor = Colors.green;
      textColor = Colors.white;
      iconData = Icons.check_circle;
      break;
    case SnackBarType.info:
      backgroundColor = Colors.grey[200];
      textColor = Colors.black;
      iconData = Icons.info_outline;
      break;
    default:
      backgroundColor = Colors.grey;
      textColor = Colors.black;
      iconData = Icons.info_outline;
  }

  return SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: const EdgeInsets.all(16),
    duration: const Duration(seconds: 1),
    backgroundColor: backgroundColor,
    content: Material(
      color: backgroundColor,
      child: Row(
        children: [
          Icon(iconData, color: textColor),
          const SizedBox(width: 8),
          Text(
            message,
            style: TextStyle(color: textColor, fontSize: 15),
          ),
        ],
      ),
    ),
  );
}
