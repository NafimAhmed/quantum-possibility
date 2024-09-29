import 'package:get/get.dart';

import '../controllers/reactions_controller.dart';

class ReactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReactionsController>(
      () => ReactionsController(),
    );
  }
}
