import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/feature/home/data/models/product_model.dart';
import 'package:grocery_app/feature/home/presentation/view_model/product_cubit/proudect_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(InitialProductState());

  List<ProductModdel> productList = [];
  List<ProductModdel> productsOnSaleList = [];
  List<ProductModdel> searchProductList = [];
  List<ProductModdel> productListCategory = [];
  List<ProductModdel> productListCart = [];
  TextEditingController searchController = TextEditingController();
  TextEditingController searchControllerCategry = TextEditingController();
  Map<String, int> quantityOfProducts = {};
  getProduct() async {
    try {
      emit(LoadingGetProductState());
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      productList =
          snapshot.docs.map((doc) => ProductModdel.fromFirebase(doc)).toList();

      productsOnSaleList =
          productList.where((element) => element.isOnSale == true).toList();
      // print('category name ${productListCategory[0].category}');

      emit(SuccessGetProductState());
    } on FirebaseException catch (e) {
      emit(FailureGetProductState(e.toString()));
    }
  }

  List<ProductModdel> searchProduct(String searchText) {
    searchProductList = productList
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    emit(SuccessGetSearchProductState());
    return searchProductList;
  }

  //inrease quintity by 1
  increaseQuntityByOny({
    required String productId,
  }) {
    quantityOfProducts[productId] = (quantityOfProducts[productId] ?? 1) + 1;
    emit(IncreaseProductQuntityByOnyState());
  }

//decrese quintity by 1
  decreaseQuntityByOny({
    required String productId,
  }) {
    if (quantityOfProducts[productId] != 1) {
      quantityOfProducts[productId] = (quantityOfProducts[productId] ?? 1) - 1;
    }
    emit(IncreaseProductQuntityByOnyState());
  }

  //get by product name
  List<ProductModdel> getProductByName(String categoryName) {
    productListCategory = productList
        .where((element) =>
            element.category.toLowerCase().contains(categoryName.toLowerCase()))
        .toList();
    emit(SuccessGetProductByNameState());
    return productListCategory;
  }

  //get product by id
  findProdById(String productId) {
    return productList.firstWhere((element) => element.id == productId);
  }
  clearState(){
    emit(InitialProductState());
  }
}
