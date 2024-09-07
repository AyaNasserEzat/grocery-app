import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:grocery_app/feature/home/presentation/view/proudect_view.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/bloc_builder_heart.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/btnAddToCart.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    required this.productModdel,
    super.key,
  });
  final ProductModdel productModdel;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: AppColors.white,
      child: GestureDetector(
        onTap: () {
          navigate(
              context,
              ProudectView(
                productModdel: productModdel,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    productModdel.imageUrl,
                    width: 130,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  HeartBtn(productModdel: productModdel),
                ],
              ),
              Text(
                productModdel.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.greenDeep),
              ),
              Row(
                children: [
                  Text(
                    r'$' + productModdel.price.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                        fontSize: 22),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  productModdel.salePrice == 0
                      ? Container()
                      : Text(
                          productModdel.salePrice.toString()+r'$',
                          style: const TextStyle(
                            fontSize: 17,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    '1',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.greenDeep),
                  ),
                  Text(
                    productModdel.isPiece,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.greenDeep),
                  ),
                ],
              ),
              BtnAddToCart(
                productModdel: productModdel,
                quantity: BlocProvider.of<ProductCubit>(context)
                        .quantityOfProducts[productModdel.id] ??
                    1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
