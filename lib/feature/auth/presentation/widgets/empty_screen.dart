import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/elvated_btn.dart';
import 'package:grocery_app/feature/home/presentation/view/all_product_view.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.imageUrl, required this.text});
  final String imageUrl, text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              height: 300,
              width: 300,
            ),
            const Text(
              'oops!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.green,
                  fontSize: 30),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.green,
                  fontSize: 30),
            ),
            const SizedBox(
              height: 6,
            ),
            ElvatedButon(
                text: 'shop now',
                onPressed: () {
                  navigate(context, const AllProductView());
                })
          ],
        ),
      ),
    );
  }
}
