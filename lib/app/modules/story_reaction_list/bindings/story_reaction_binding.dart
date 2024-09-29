import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/modules/story_reaction_list/controller/story_reaction_controller.dart';

class StoryReactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoryReactionController>(() => StoryReactionController());
  }
}
