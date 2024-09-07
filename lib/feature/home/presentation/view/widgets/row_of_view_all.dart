import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/feature/home/presentation/view/proudect_onsale_view.dart';
import 'package:iconly/iconly.dart';

class RowOfViewAll extends StatelessWidget {
  const RowOfViewAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'on sale',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
              color: AppColors.greenDeep),
        ),
        const SizedBox(
          width: 5,
        ),
        const Icon(IconlyLight.discount, size: 20, color: AppColors.greenDeep),
        const Spacer(),
        TextButton(
          onPressed: () {
            navigate(context, const ProudectOnsaleView());
          },
          child: const Text(
            'View All',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.greenDeep),
          ),
        ),
      ],
    );
  }
}
