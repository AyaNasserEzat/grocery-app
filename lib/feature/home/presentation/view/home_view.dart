import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_state.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/product_item.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/row_of_browse.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/onsale_bloc_builder.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/swiper_widget.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/row_of_view_all.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      ProductCubit productCubit=BlocProvider.of<ProductCubit>(context);
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SwiperWidget(),
              const SizedBox(
                height: 10,
              ),
              const RowOfViewAll(),
              const OnsaleBlocBuilder(),
              const RowOfBrowse(),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    productCubit.productList.length<=4?productCubit.productList.length:4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 150 / 190,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return ProductItem(
                    productModdel: BlocProvider.of<ProductCubit>(context)
                        .productList[index],
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
