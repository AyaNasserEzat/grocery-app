import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/feature/home/presentation/view/all_product_view.dart';

class RowOfBrowse extends StatelessWidget {
  const RowOfBrowse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'our proudects ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27,
                color: AppColors.greenDeep),
          ),
          TextButton(
            onPressed: () {
              navigate(context, const AllProductView());
            },
            child: const Text(
              'Browse All',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.greenDeep),
            ),
          ),
        ],
      ),
    );
  }
}
