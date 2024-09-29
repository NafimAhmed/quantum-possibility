import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/market_place_data.dart';
import '../../../../models/marketplace_product.dart';

class CartController extends GetxController {
  late MarketPlaceData marketPlaceData;
  List<MarketPlaceProduct>? cartProductList = [];
  RxBool isLoadingCartProduct = true.obs;

  @override
  void onInit() {
    marketPlaceData = MarketPlaceData();
    super.onInit();
  }

  void getProductFromCart() {
    cartProductList!.clear();

    isLoadingCartProduct.value = true;

    List<MarketPlaceProduct>? fetchCardListFromLocal =
        marketPlaceData.getUserCartData();

    cartProductList = fetchCardListFromLocal ?? [];

    debugPrint('cart list ..............$cartProductList');

    isLoadingCartProduct.value = false;
  }
}
