
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_assets.dart';
import 'package:grocery_app/core/utils/app_colors.dart';

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            AppAssets.emptyOrder,
            width: 250,
            height: 250,
          ),
          const Text(
            textAlign: TextAlign.center,
            'no such product found try again',
            style:
                TextStyle(color: AppColors.green, fontSize: 25),
          ),
        ],
      );
  }
}
