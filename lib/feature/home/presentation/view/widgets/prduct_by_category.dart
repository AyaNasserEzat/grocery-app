import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/custom_gridview.dart';
import 'package:grocery_app/core/widgets/custom_search_widget.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/empty_search_widget.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_state.dart';
import 'package:grocery_app/feature/home/presentation/view/bottomVavigtion.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/product_item.dart';
import 'package:iconly/iconly.dart';

class ProductsOfCategory extends StatelessWidget {
  const ProductsOfCategory({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      ProductCubit productCubit = BlocProvider.of<ProductCubit>(context);
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title:  Text(
           text,
            style: const TextStyle(color: AppColors.green),
          ),
          leading: IconButton(
            onPressed: () {
              navigate(context, const BottomvavigtionView());
            },
            icon: const Icon(
              IconlyLight.arrow_left,
              color: AppColors.green,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                CustomSrearchWidget(
                    textEditingController: productCubit.searchController,
                    onChanged: (value) {
                      productCubit.searchProduct(value);
                    }),
                productCubit.searchController.text.isNotEmpty &&
                        productCubit.searchProductList.isEmpty
                    ? const EmptySearchWidget()
                    : Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: CustomGridView(
                          itemBuilder: (context, index) {
                            return ProductItem(
                              productModdel: state is SuccessGetSearchProductState
                                  ? productCubit.searchProductList[index]
                                  : productCubit.productListCategory[index],
                            );
                          },
                          itemCount: state is SuccessGetSearchProductState
                              ? productCubit.searchProductList.length
                              : productCubit.productListCategory.length,
                        ),
                    ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
