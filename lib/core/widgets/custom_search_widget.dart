import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_colors.dart';

class CustomSrearchWidget extends StatelessWidget {
  const CustomSrearchWidget({
    required this.textEditingController,
    required this.onChanged,
    super.key,
  });
  final TextEditingController textEditingController;
  final void Function(String value)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onChanged: onChanged,
      style: const TextStyle(
        color: AppColors.green,
      ),
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.green,
        ),
        hintText: "Search",
        hintStyle: TextStyle(color: AppColors.green),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.green),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.green),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.green),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
