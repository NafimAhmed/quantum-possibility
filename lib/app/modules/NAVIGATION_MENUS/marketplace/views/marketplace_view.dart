import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../components/button.dart';
import '../../../../config/api_constant.dart';
import '../../../../config/app_assets.dart';
import '../../../../utils/color.dart';
import '../../../../utils/date_time.dart';
import '../controllers/marketplace_controller.dart';
import 'marketplace_detail.dart';

class MarketplaceView extends GetView<MarketplaceController> {
  const MarketplaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    var currentRangeValues = const RangeValues(0, 1000000).obs;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        width: 250,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Filters',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      icon: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              ExpansionTile(
                title: const Text(
                  'Category',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                children:
                List.generate(
                  controller.categoryList.value.length,
                  (index) => GestureDetector(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: () {
                        controller.categoryName.value = controller
                            .categoryList.value[index].categoryName
                            .toString();
                        controller.getSearchProductList();
                        scaffoldKey.currentState!.closeEndDrawer();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, top: 5, bottom: 5),
                            child: Text(
                              controller.categoryList.value[index].categoryName!
                                  .toUpperCase(),
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ExpansionTile(
                title: const Text(
                  'Brands',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                children: List.generate(
                  controller.categoryList.value.length,
                  (index) => Obx(() => RadioListTile(
                        activeColor: PRIMARY_COLOR,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          controller.brandList.value[index].brandName!
                              .toUpperCase(),
                          style: const TextStyle(fontSize: 17),
                        ),
                        value: controller.brandList.value[index].brandName!
                            .toString(),
                        groupValue: controller.brandName.value,
                        onChanged: (String? value) {
                          controller.brandName.value = value.toString();
                          controller.getSearchProductList();
                          scaffoldKey.currentState!.closeEndDrawer();
                        },
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ExpansionTile(
                title: const Text(
                  'Price Range',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                children: [
                  Obx(
                    () => Column(
                      children: [
                        RangeSlider(
                          values: currentRangeValues.value,
                          max: 1000000,
                          min: 0,
                          inactiveColor: COLOR_PEST,
                          activeColor: PRIMARY_COLOR,
                          divisions: 1000,
                          onChanged: (RangeValues values) {
                            currentRangeValues.value = values;
                            controller.maxPriceController.text =
                                values.start.toString();
                            controller.minPriceController.text =
                                values.end.toString();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Max',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextFormField(
                                        controller:
                                            controller.maxPriceController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Min',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextFormField(
                                        controller:
                                            controller.minPriceController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PrimaryOutlinedButton(
                          onPressed: () {
                            controller.getSearchProductList();
                            scaffoldKey.currentState!.closeEndDrawer();
                          },
                          text: 'Apply',
                          horizontalPadding: 100,
                          verticalPadding: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                flex: 2,
                child: Container(
                    height: 45,
                    width: Get.width - 150,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextFormField(
                      controller: controller.searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search on marketplace',
                        icon: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (searchTextValue) {
                        if (controller.searchController.text.length > 1) {
                          controller.getSearchProductList();
                        }
                      },
                    )),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: Container(
                    height: 45,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.filter_list,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Filter',
                            style: TextStyle(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: Obx(() => controller.isLoadingMarketplaceProduct.value ==
                      true
                  ? const Center(child: CircularProgressIndicator())
                  : controller.productList.value.isEmpty
                      ? const Center(
                          child: Text('No product found !!!'),
                        )
                      : Obx(() => RefreshIndicator(
                            onRefresh: () async {
                              await controller.getMarketPlaceProduct();
                              controller.searchController.text = '';
                            },
                            child: GridView.count(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              childAspectRatio: Get.width / (Get.height * 0.60),
                              children: List.generate(
                                controller.productList.value.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Get.to(() => const MarketPlaceDetailView(),
                                        arguments: index);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(15.0),
                                          topLeft: Radius.circular(15.0),
                                          bottomLeft: Radius.circular(15.0),
                                          bottomRight: Radius.circular(15.0),
                                        ),
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.5))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15.0),
                                                    topLeft:
                                                        Radius.circular(15.0)),
                                            child: FadeInImage(
                                              image: NetworkImage(
                                                '${ApiConstant.SERVER_IP_PORT}/uploads/product/${controller.productList.value[index].image_path.toString()}',
                                              ),
                                              placeholder: const AssetImage(
                                                AppAssets.DEFAULT_IMAGE,
                                              ),
                                              height: Get.height * 0.11,
                                              width: 200,
                                              fit: BoxFit.cover,
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image(
                                                  height: Get.height * 0.11,
                                                  width: 200,
                                                  fit: BoxFit.cover,
                                                  image: const AssetImage(
                                                      AppAssets.DEFAULT_IMAGE),
                                                );
                                              },
                                            )),
                                        SizedBox(
                                          height: Get.height * 0.005,
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Text(
                                              controller.productList
                                                  .value[index].product_name
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: Get.height * 0.016,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.003,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: SizedBox(
                                                width: 70,
                                                child: Text(
                                                  ' USD ${controller.productList.value[index].price}',
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize:
                                                          Get.height * 0.015,
                                                      color: PRIMARY_COLOR,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              height: 20,
                                              child: RatingBar.builder(
                                                initialRating: 3,
                                                ignoreGestures: true,
                                                minRating: 1,
                                                direction: Axis.vertical,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 14,
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.003,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: SizedBox(
                                                width: 80,
                                                child: Text(
                                                  ' ${controller.productList.value[index].product_store?.name ?? ''}................',
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize:
                                                        Get.height * 0.016,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                              child: SizedBox(
                                                width: 80,
                                                child: Text(
                                                  productUploadTimeText(
                                                      controller
                                                          .productList
                                                          .value[index]
                                                          .createdAt
                                                          .toString()),
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.005,
                                        ),
                                        const Expanded(child: SizedBox()),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: AddCartButton(
                                              text: 'Add to cart',
                                              horizontalPadding: 60,
                                              verticalPadding: 40,
                                              onPressed: () {
                                                controller.saveProductToCart(
                                                    controller.productList
                                                        .value[index]);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))))
        ],
      ),
    );
  }

  String productUploadTimeText(String dateTime) {
    DateTime postDateTime = DateTime.parse(dateTime).toLocal();
    DateTime currentDatetime = DateTime.now();
    // Calculate the difference in milliseconds
    int millisecondsDifference = currentDatetime.millisecondsSinceEpoch -
        postDateTime.millisecondsSinceEpoch;
    // Convert to minutes (ignoring milliseconds)
    int minutesDifference =
        (millisecondsDifference / Duration.millisecondsPerMinute).truncate();

    if (minutesDifference < 1) {
      return 'a few sec ago';
    } else if (minutesDifference < 30) {
      return '$minutesDifference minutes ago';
    } else if (DateUtils.isSameDay(postDateTime, currentDatetime)) {
      return 'Today at ${postTimeFormate.format(postDateTime)}';
    } else {
      return productDateTimeFormate.format(postDateTime);
    }
  }
}
