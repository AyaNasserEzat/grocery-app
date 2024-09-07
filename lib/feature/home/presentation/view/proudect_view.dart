import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/elvated_btn.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:grocery_app/feature/home/presentation/view/bottomVavigtion.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/bloc_builder_heart.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/btnAddToCart.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/plus_mins_product.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_state.dart';

class ProudectView extends StatelessWidget {
  const ProudectView({required this.productModdel, super.key});
  final ProductModdel productModdel;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context)
        .quantityOfProducts[productModdel.id] = 1;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              navigate(context, const BottomvavigtionView());
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          SizedBox(height: 350, child: Image.network(productModdel.imageUrl)),
          Material(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productModdel.category,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      HeartBtn(productModdel: productModdel),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                      r'$'+  productModdel.price.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 25),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      productModdel.isOnSale?
                      Text(
                        '${productModdel.salePrice}'r'$',
                        style: const TextStyle(fontSize: 20,decoration: TextDecoration.lineThrough),
                      ):Container(),
                      const SizedBox(
                        width: 70,
                      ),
                      ElvatedButon(
                        text: 'free dlivery',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  PlusMinsProduct(productModdel: productModdel),
                  const SizedBox(
                    height: 105,
                  ),
                  BlocBuilder<ProductCubit, ProductState>(
                      builder: (context, state) {
                    return Row(
                      children: [
                        Column(
                          children: [
                            const Text('total'),
                            Text(
                              '${ (productModdel.isOnSale?productModdel.salePrice: productModdel.price )* (BlocProvider.of<ProductCubit>(context).quantityOfProducts[productModdel.id] ?? 1)}',
                            ),
                          ],
                        ),
                        const Spacer(),
                        BtnAddToCart(
                          productModdel: productModdel,
                          quantity: (BlocProvider.of<ProductCubit>(context)
                                  .quantityOfProducts[productModdel.id] ??
                              1),
                        )
                      ],
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
