import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/data/login_creadential.dart';

import '../../../components/friend.dart';
import '../../../models/friend.dart';
import '../../../routes/app_pages.dart';
// import '../../other_profile_view/controller/other_profile_controller.dart';
import '../controller/other_friend_list_controller.dart';

class OtherFriendList extends GetView<OtherProfileFriendController> {
  const OtherFriendList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Friends List',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        //surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [


          SizedBox(height: 10,),

       // Container(
       //   margin: EdgeInsets.symmetric(horizontal: 20),
       //   child: SearchAnchor(
       //       viewElevation: 0,
       //       viewHintText: 'Search a friend',
       //       builder: (BuildContext context, SearchController anchorController) {
       //         return SearchBar(
       //           hintText: 'Search a friend',
       //
       //           controller: anchorController,
       //           padding: const MaterialStatePropertyAll<EdgeInsets>(
       //               EdgeInsets.symmetric(horizontal: 16.0)),
       //           onTap: () {
       //             anchorController.openView();
       //           },
       //           onChanged: (value) {
       //             anchorController.openView();
       //             //controller.searchString.value=value;
       //           },
       //           leading: const Icon(Icons.search),
       //
       //         );
       //       },
       //
       //       suggestionsBuilder: (BuildContext context, SearchController searchController) {
       //
       //         return List<ListTile>.generate(controller.friendList.value.length, (int index) {
       //
       //           final String item = '${controller.friendList.value[index].user_id?.first_name} ${controller.friendList.value[index].user_id?.last_name}';
       //           return ListTile(
       //             title: Text(item),
       //             onTap: () {
       //               // setState(() {
       //               searchController.closeView(item);
       //               // });
       //             },
       //           );
       //         });
       //       }),
       // ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(.3)),
            child: Column(
              children: [
                 TextField(
                   // controller: controller.searchCont,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Search friends'),

                  onChanged: (value) {



                    if (value.isNotEmpty) {
                       controller.searchCont.value = value;
                      controller.friendSearchList.value.clear();

                      controller.friendSearchList.value = controller
                          .friendList.value
                          .where((friendModel) =>
                      friendModel.user_id!.username
                          .toString()
                          .toUpperCase()
                          .contains(value.toString().toUpperCase()) ||
                          friendModel.user_id!.first_name
                              .toString()
                              .toUpperCase()
                              .contains(value.toString().toUpperCase()) ||
                          friendModel.user_id!.last_name
                              .toString()
                              .toUpperCase()
                              .contains(value.toString().toUpperCase()))
                          .toList();

                      debugPrint(
                          'friend controller .....${controller.friendSearchList.value}');
                    } else {
                      controller.searchCont.value = '';
                    }








                  },


                ),





              ],
            ),
          ),



          SizedBox(height: 10,),



          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Obx(
                  () => RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: 'Friends',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' (${controller.friendList.value.length.toString()})',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ])),
                )),

                // const Text(
                //   'Sell All',
                //   style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: PRIMARY_COLOR),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() => controller.username != LoginCredential().getUserData().username ?

                 // controller.searchCont.value.length == 1 ?

            ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.friendList.value.length,
                  itemBuilder: (context, index) {
                    FriendModel friendModel =
                        controller.friendList.value[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.OTHERS_PROFILE,
                            arguments: friendModel.user_id?.username);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FriendCard(
                          model: friendModel, otherOptions: false,
                        ),
                      ),
                    );
                  },
                )

                 // :
                 //
                 // ListView.builder(
                 //   physics: const ScrollPhysics(),
                 //   shrinkWrap: true,
                 //   itemCount: controller.friendSearchList.value.length,
                 //   itemBuilder: (context, index) {
                 //     FriendModel friendModel =
                 //     controller.friendList.value[index];
                 //     return InkWell(
                 //       onTap: () {
                 //         Get.toNamed(Routes.OTHERS_PROFILE,
                 //             arguments: friendModel.user_id?.username);
                 //       },
                 //       child: Padding(
                 //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 //         child: FriendCard(
                 //           model: friendModel, otherOptions: false,
                 //         ),
                 //       ),
                 //     );
                 //   },
                 // )



                     :

            // controller.searchCont.value.length == 1  ?

            ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.friendList.value.length,
              itemBuilder: (context, index) {
                FriendModel friendModel =
                controller.friendList.value[index];




                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.OTHERS_PROFILE,
                        arguments: friendModel.user_id?.username);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FriendCard(
                      model: friendModel, otherOptions: true,
                    ),
                  ),
                );
              },
            )
            //         :
            //
            // ListView.builder(
            //   physics: const ScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: controller.friendSearchList.value.length,
            //   itemBuilder: (context, index) {
            //     FriendModel friendModel =
            //     controller.friendList.value[index];
            //
            //
            //
            //
            //     return InkWell(
            //       onTap: () {
            //         Get.toNamed(Routes.OTHERS_PROFILE,
            //             arguments: friendModel.user_id?.username);
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //         child: FriendCard(
            //           model: friendModel, otherOptions: true,
            //         ),
            //       ),
            //     );
            //   },
            // )


            ),
          ),
        ],
      ),
    );
  }
}
