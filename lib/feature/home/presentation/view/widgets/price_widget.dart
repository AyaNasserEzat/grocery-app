import 'package:flutter/material.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';

class priceWidget extends StatelessWidget {
  const priceWidget({
    required this.productModdel,
    super.key,
  });
  final ProductModdel productModdel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          r'$' + productModdel.price.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 25),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          productModdel.salePrice.toString()+r'$',
          style: const TextStyle(
            fontSize: 20,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }
}
