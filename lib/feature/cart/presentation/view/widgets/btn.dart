import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_colors.dart';

class butn extends StatelessWidget {
  butn({
    required this.icon,
    required this.onTap,
    this.padding,
    super.key,
  });
  final void Function()? onTap;
  final IconData icon;
  double? padding = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: AppColors.green),
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0),
          child: Icon(
            icon,
            color: AppColors.white,
            size: 25,
          ),
        ),
      ),
    );
  }
}
