import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/order/data/models/order_model.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key, required this.ordersModel}) : super(key: key);
  final OrderModel ordersModel;
  @override
  Widget build(BuildContext context) {
    final getcurrentProduct = BlocProvider.of<ProductCubit>(context)
        .findProdById(ordersModel.productId);
    var orderDate = ordersModel.orderDate.toDate();
    String orderDateToShow =
        '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    return Material(
      color: AppColors.white,
      child: ListTile(
        subtitle: Text(
            'Paid: \$${(ordersModel.quantity * ordersModel.price).toStringAsFixed(2)}'),
        leading: Image.network(
          ordersModel.imageUrl,
          height: 100,
          width: 100,
        ),
        title: Text(
          '${getcurrentProduct.title}  x${ordersModel.quantity}',
        ),
        trailing: Text(
          orderDateToShow,
        ),
      ),
    );
  }
}
