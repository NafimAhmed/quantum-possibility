import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/market_place_data.dart';

import '../../../../config/api_constant.dart';
import '../../../../data/login_creadential.dart';
import '../../../../models/marketplace_product.dart';
import '../../../../models/product_brand.dart';
import '../../../../models/product_category.dart';
import '../../../../services/api_communication.dart';
import '../../../../utils/snackbar.dart';

class MarketplaceController extends GetxController {
  late ApiCommunication _apiCommunication;
  late MarketPlaceData _marketPlaceData;
  RxBool isLoadingMarketplaceProduct = true.obs;
  Rx<List<MarketPlaceProduct>> productList = Rx([]);
  Rx<List<ProductData>> categoryList = Rx([]);
  Rx<List<ProductBrand>> brandList = Rx([]);
  TextEditingController searchController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  RxString categoryName = ''.obs;
  RxString brandName = ''.obs;
  RxString price = ''.obs;

  Future<void> getMarketPlaceProduct() async {
    productList.value.clear();

    debugPrint('market call..........');

    isLoadingMarketplaceProduct.value = true;

    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'get-all-product',
    );
    isLoadingMarketplaceProduct.value = false;

    debugPrint('market call..........${apiResponse.statusCode}');

    if (apiResponse.isSuccessful) {
      productList.value.addAll(
          (((apiResponse.data as Map<String, dynamic>)['data']) as List)
              .map((element) => MarketPlaceProduct.fromMap(element))
              .toList());

      debugPrint('status code from market list..........${productList.value}');
    } else {}
  }

  Future<void> getMarketPlaceCategory() async {
    isLoadingMarketplaceProduct.value = true;

    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'get-all-category',
    );
    isLoadingMarketplaceProduct.value = false;

    debugPrint(
        'status code from market controller..........${apiResponse.statusCode}');

    if (apiResponse.isSuccessful) {
      categoryList.value.addAll(
          (((apiResponse.data as Map<String, dynamic>)['data']) as List)
              .map((element) => ProductData.fromJson(element))
              .toList());

      debugPrint('status code from market list..........${productList.value}');
    } else {}
  }

  Future<void> getMarketPlaceBrand() async {
    isLoadingMarketplaceProduct.value = true;

    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'get-all-brand',
    );
    isLoadingMarketplaceProduct.value = false;

    debugPrint(
        'status code from market controller..........${apiResponse.statusCode}');

    if (apiResponse.isSuccessful) {
      brandList.value.addAll(
          (((apiResponse.data as Map<String, dynamic>)['data']) as List)
              .map((element) => ProductBrand.fromJson(element))
              .toList());

      debugPrint('status code from market list..........${productList.value}');
    } else {}
  }

  Future<void> getSearchProductList() async {
    productList.value.clear();
    isLoadingMarketplaceProduct.value = true;
    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'search-product',
      requestData: {
        'title': searchController.text,
        'category_name': categoryName.value,
        'brand_name': brandName.value,
        'max_price': minPriceController.text,
        'min_price': minPriceController.text
      },
    );

    isLoadingMarketplaceProduct.value = false;

    if (apiResponse.isSuccessful) {
      productList.value.addAll(
          (((apiResponse.data as Map<String, dynamic>)['data']) as List)
              .map((element) => MarketPlaceProduct.fromJson(element))
              .toList());
    } else {
      debugPrint(apiResponse.message);
    }
  }

  void saveProductToCart(MarketPlaceProduct productModel) {
    debugPrint('function call start');
    _marketPlaceData.saveUserCartData(productModel);
     showSnackkbar(titile: 'Success', message: 'Product add to cart');
  }

  @override
  void onInit() {
    _apiCommunication = ApiCommunication();
    _marketPlaceData = MarketPlaceData();
    getMarketPlaceProduct();
    getMarketPlaceCategory();
    getMarketPlaceBrand();
    super.onInit();
  }
}
