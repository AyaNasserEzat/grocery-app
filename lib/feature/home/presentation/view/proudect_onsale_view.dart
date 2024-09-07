import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/empty_search_widget.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_state.dart';
import 'package:grocery_app/feature/home/presentation/view/bottomVavigtion.dart';

import 'package:grocery_app/feature/home/presentation/view/widgets/onsall_widget.dart';
import 'package:iconly/iconly.dart';

class ProudectOnsaleView extends StatelessWidget {
  const ProudectOnsaleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text(
            'proudect on sale ',
            style: TextStyle(color: AppColors.green),
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
        body: BlocProvider.of<ProductCubit>(context).productsOnSaleList.isEmpty
            ? const EmptySearchWidget()
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: BlocProvider.of<ProductCubit>(context)
                    .productsOnSaleList
                    .length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 240 / 250,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return OnSallWidget(
                    productModdel: BlocProvider.of<ProductCubit>(context)
                        .productsOnSaleList[index],
                  );
                },
              ),
      );
    });
  }
}
