
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color.dart';
import '../controllers/edit_post_controller.dart';

class EditCheckIn extends GetView<EditPostController>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'Choose Location',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
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
                  hintText: 'Search location',
                  hintStyle: TextStyle(fontSize: 15),
                  border: InputBorder.none),
              onChanged: (value) async {
                controller.locationSearch.value = value.toString();
                await controller.getLocation();
              },
            ),
          ),
          Expanded(
              child: Obx(
                    () => controller.isLocationLoading.value == true
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.locationList.value.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {

                          debugPrint("edit location id ..............."+controller.locationId.value);


                          controller.locationId.value = controller
                              .locationList.value[index].id
                              .toString();
                          Get.back(
                              result: controller.locationList.value[index]);

                          debugPrint("edit location id ..............."+controller.locationId.value);
                        },
                        leading: const Icon(
                          Icons.location_on,
                          size: 37,
                          color: PRIMARY_COLOR,
                        ),
                        title: Text(controller
                            .locationList.value[index].locationName
                            .toString()),
                      );
                    }),
              ))
        ],
      ),
    );
  }

}