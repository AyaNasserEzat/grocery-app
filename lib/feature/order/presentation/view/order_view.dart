import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_assets.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/core/widgets/custom_loading.dart';
import 'package:grocery_app/feature/auth/presentation/widgets/empty_screen.dart';
import 'package:grocery_app/feature/home/presentation/view/bottomVavigtion.dart';
import 'package:grocery_app/feature/order/presentation/view_model/order_cubit.dart';
import 'package:grocery_app/feature/order/presentation/view_model/order_state.dart';
import 'package:grocery_app/feature/order/presentation/widgets/order_widgets.dart';
import 'package:iconly/iconly.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
      OrderCubit orderCubit = BlocProvider.of<OrderCubit>(context);
      if(state is LoadingGetOrderState){return  Container(color: Colors.white,);}
      if (orderCubit.orderUserList.isEmpty) {
        return const EmptyScreen(
          imageUrl: AppAssets.emptyOrder,
          text: 'your order is empty',
        );
      } else {
        return Scaffold(
            backgroundColor: AppColors.primaryColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  navigate(context, const BottomvavigtionView());
                },
                icon: const Icon(
                  IconlyLight.arrow_left,
                  color: AppColors.green,
                ),
              ),
              elevation: 0,
              centerTitle: false,
              title: Text(
                'Your orders (${orderCubit.orderUserList.length})',
                style: const TextStyle(color: AppColors.green),
              ),
              backgroundColor: AppColors.white,
            ),
            body: ListView.builder(
              itemCount: orderCubit.orderUserList.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child:
                        OrderWidget(ordersModel: orderCubit.orderUserList[index]));
              },
            ));
      }
    });
  }
}
