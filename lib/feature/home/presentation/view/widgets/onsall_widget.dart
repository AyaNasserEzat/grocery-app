import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:grocery_app/feature/home/presentation/view/proudect_view.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/bloc_builder_heart.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/cartBag.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/price_widget.dart';

class OnSallWidget extends StatelessWidget {
  const OnSallWidget({
    required this.productModdel,
    super.key,
  });
  final ProductModdel productModdel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap: () {
            navigate(
                context,
                ProudectView(
                  productModdel: productModdel,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.network(
                      productModdel.imageUrl,
                      width: 90,
                      height: 90,
                    ),
                    Column(
                      children: [
                        Text(
                          '1${productModdel.isPiece}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.greenDeep),
                        ),
                        Row(
                          children: [
                            Cartbag(productModdel: productModdel),
                            HeartBtn(productModdel: productModdel),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                priceWidget(
                  productModdel: productModdel,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  productModdel.title,
                  style: const TextStyle(color: AppColors.green),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
