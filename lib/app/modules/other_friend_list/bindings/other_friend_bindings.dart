



import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/modules/other_friend_list/controller/other_friend_list_controller.dart';

class OtherFriendListBindings extends Bindings{
  @override
  void dependencies() {



    Get.lazyPut<OtherProfileFriendController>(() => OtherProfileFriendController());
    // TODO: implement dependencies
  }

}