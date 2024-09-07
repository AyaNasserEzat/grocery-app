import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/commans.dart';
import 'package:grocery_app/feature/home/data/models/category_model.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_cubit.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/prduct_by_category.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    required this.categoryModel,
    super.key,
  });
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        BlocProvider.of<ProductCubit>(context)
            .getProductByName(categoryModel.catname);
        navigate(
            context,
            ProductsOfCategory(
              text: categoryModel.catname,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 2, color: AppColors.white),
        ),
        child: Column(
          children: [
            Container(
              width: screenwidth * 0.35,
              height: screenhight * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(categoryModel.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              categoryModel.catname,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green),
            )
          ],
        ),
      ),
    );
    //   }
    // );
  }
}
