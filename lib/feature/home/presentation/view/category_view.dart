import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_assets.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/app_strings.dart';
import 'package:grocery_app/feature/home/data/models/category_model.dart';
import 'package:grocery_app/feature/home/presentation/view/widgets/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList = [
      CategoryModel(
          image: AppAssets.fruitsCat,
          catname: AppStrings.fruits,
         ),
           CategoryModel(
          image: AppAssets.vegCat,
          catname: AppStrings.veg,
         ),
      CategoryModel(
          image: AppAssets.grainsCat,
          catname: AppStrings.grains,
          ),
      CategoryModel(
          image: AppAssets.nutsCat,
          catname: AppStrings.nuts,
         ),
      CategoryModel(
          image: AppAssets.spicesCat,
          catname: AppStrings.spices,
         ),
      CategoryModel(
          image: AppAssets.spinachCat,
          catname: AppStrings.spinach,
         )
    ];
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Category',
          style: TextStyle(color: AppColors.green),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: categoryList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 180 / 200,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return CategoryWidget(categoryModel: categoryList[index]);
          },
        ),
      ),
    );
  }
}
