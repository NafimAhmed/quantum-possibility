import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/color.dart';

import '../../../../config/api_constant.dart';
import '../../../../config/app_assets.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getProductFromCart();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => controller.isLoadingCartProduct.value == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.cartProductList!.isEmpty
                        ? SizedBox(
                            height: Get.height / 2,
                            width: Get.width,
                            child: const Center(
                              child: Text(
                                'No product added to cart',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: controller.cartProductList!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      '${controller.cartProductList![index].product_store!.name}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      height: Get.height * 0.30,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(15.0),
                                            topLeft: Radius.circular(15.0),
                                            bottomLeft: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0),
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), //color of shadow
                                              spreadRadius: 1, //spread radius
                                              blurRadius: 15, // blur radius
                                              offset: const Offset(0,
                                                  2), // changes position of shadow
                                              //first paramerter of offset is left-right
                                              //second parameter is top to down
                                            ),
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    15.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15.0)),
                                                    child: FadeInImage(
                                                      image: NetworkImage(
                                                        '${ApiConstant.SERVER_IP_PORT}/uploads/product/${controller.cartProductList![index].image_path.toString()}',
                                                      ),
                                                      placeholder:
                                                          const AssetImage(
                                                        AppAssets.DEFAULT_IMAGE,
                                                      ),
                                                      height: Get.height * 0.22,
                                                      width: Get.width * 0.45,
                                                      fit: BoxFit.cover,
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image(
                                                          height:
                                                              Get.height * 0.22,
                                                          width:
                                                              Get.width * 0.45,
                                                          fit: BoxFit.cover,
                                                          image: const AssetImage(
                                                              AppAssets
                                                                  .DEFAULT_IMAGE),
                                                        );
                                                      },
                                                    )),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: Get.height * 0.020,
                                                    ),
                                                    child: Text(
                                                      '${controller.cartProductList![index].product_name}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: PRIMARY_COLOR,
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.005,
                                                  ),
                                                  Text(
                                                    '${controller.cartProductList![index].category_name}',
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: PRIMARY_COLOR),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.005,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Brand : ',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                PRIMARY_COLOR),
                                                      ),
                                                      Text(
                                                        '${controller.cartProductList![index].brand_name}',
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.005,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Discount : ',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: PRIMARY_COLOR,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${controller.cartProductList![index].discount}',
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.005,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Weight : ',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: PRIMARY_COLOR,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${controller.cartProductList![index].weight}',
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.005,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Condition : ',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: PRIMARY_COLOR,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${controller.cartProductList![index].product_condition}',
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.005,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Tax : ',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: PRIMARY_COLOR,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${controller.cartProductList![index].tax}',
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Divider(
                                              height: 1.0,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.width * 0.030,
                                                    top: Get.height * 0.005),
                                                child: const Text(
                                                  'Total Price : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: Get.width * 0.020,
                                                    top: Get.height * 0.005),
                                                child: Text(
                                                  '${controller.cartProductList![index].price}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 14.0, top: 3.0),
                    child: Icon(Icons.location_on_outlined),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5.0,
                    ),
                    child: Text(
                      'Delivery Address',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
