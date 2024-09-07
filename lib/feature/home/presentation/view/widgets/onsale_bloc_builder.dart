import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_state.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/onsall_widget.dart';

class OnsaleBlocBuilder extends StatelessWidget {
  const OnsaleBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      ProductCubit productCubit = BlocProvider.of<ProductCubit>(context);
      return Row(children: [
        Flexible(
          child: SizedBox(
            height: 180,
            child: ListView.builder(
              itemCount: productCubit.productsOnSaleList.length<=4?productCubit.productsOnSaleList.length:4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, indx) {
                return OnSallWidget(
                  productModdel: productCubit.productsOnSaleList[indx],
                );
              },
            ),
          ),
        ),
      ]);
    });
  }
}
