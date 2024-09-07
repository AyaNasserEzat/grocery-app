import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/feature/cart/presentation/view/widgets/btn.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_state.dart';

class PlusMinsProduct extends StatelessWidget {
  const PlusMinsProduct({
    required this.productModdel,
    super.key,
  });
  final ProductModdel productModdel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      ProductCubit productCubit = BlocProvider.of<ProductCubit>(context);
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          butn(
            padding: 7,
            onTap: () {
              productCubit.increaseQuntityByOny(productId: productModdel.id);
            },
            icon: CupertinoIcons.add,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            '${productCubit.quantityOfProducts[productModdel.id] ?? 1} ${productModdel.isPiece}',
            style: const TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          const SizedBox(
            width: 8,
          ),
          butn(
            padding: 7,
            onTap: () {
              productCubit.decreaseQuntityByOny(productId: productModdel.id);
            },
            icon: CupertinoIcons.minus,
          ),
        ],
      );
    });
  }
}
