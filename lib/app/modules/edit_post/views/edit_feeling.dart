import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../components/image.dart';
import '../../../config/api_constant.dart';
import '../controllers/edit_post_controller.dart';

class EditFeeling extends GetView<EditPostController>{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'How are you feeling?',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search feelings',
                  hintStyle: TextStyle(fontSize: 15),
                  border: InputBorder.none),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.feelingController.value = value.toString();

                  controller.feelingSearchList.value.clear();

                  controller.feelingSearchList.value = controller
                      .feelingList.value
                      .where((feeling) => feeling.feelingName!
                      .toLowerCase()
                      .contains(
                      controller.feelingController.value.toLowerCase()))
                      .toList();

                  debugPrint(
                      'feeling search ..........${controller.feelingList}');

                  debugPrint(
                      'feeling search ..........${controller.feelingSearchList.value}');
                } else {
                  controller.feelingController.value = '';
                  controller.getFeeling();
                }
              },
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Obx(
                    () => controller.isFeelingLoading.value == true
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : controller.feelingController.value == ''
                    ? GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 15,
                      childAspectRatio: 900 / (200 * 1.05)),
                  itemCount: controller.feelingList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {


                        debugPrint("edit feeling id ..............."+controller.feelingId.value);

                        controller.feelingId.value = controller
                            .feelingList.value[index].id
                            .toString();


                        debugPrint("edit feeling id ..............."+controller.feelingId.value);
                        Get.back(
                            result: controller.feelingList.value[index]);
                      },
                      child: Container(
                          margin:
                          const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              NetworkCircleAvatar(
                                  imageUrl: getFormatedFeelingUrl(
                                      controller
                                          .feelingList.value[index].logo
                                          .toString())),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(controller
                                  .feelingList.value[index].feelingName
                                  .toString()),
                            ],
                          )),
                    );
                  },
                )
                    : GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 15,
                      childAspectRatio: 900 / (200 * 1.05)),
                  itemCount: controller.feelingSearchList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        controller.feelingId.value = controller
                            .feelingSearchList.value[index].id
                            .toString();
                        Get.back(
                            result: controller.feelingList.value[index]);
                      },
                      child: Container(
                          margin:
                          const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              NetworkCircleAvatar(
                                  imageUrl: getFormatedFeelingUrl(
                                      controller.feelingSearchList
                                          .value[index].logo
                                          .toString())),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(controller.feelingSearchList
                                  .value[index].feelingName
                                  .toString()),
                            ],
                          )),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }

  String getFormatedFeelingUrl(String path) {
    return '${ApiConstant.SERVER_IP_PORT}/assets/logo/$path';
  }

}