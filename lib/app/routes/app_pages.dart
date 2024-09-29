import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/modules/NAVIGATION_MENUS/home/views/story_carosel.dart';
import 'package:quantum_possibilities_flutter/app/modules/other_friend_list/views/other_friend_list.dart';
import 'package:quantum_possibilities_flutter/app/modules/story_reaction_list/bindings/story_reaction_binding.dart';
import 'package:quantum_possibilities_flutter/app/modules/story_reaction_list/views/story_reaction_view.dart';

import '../modules/NAVIGATION_MENUS/cart/bindings/cart_binding.dart';
import '../modules/NAVIGATION_MENUS/cart/views/cart_view.dart';
import '../modules/NAVIGATION_MENUS/friend/bindings/friend_binding.dart';
import '../modules/NAVIGATION_MENUS/friend/views/friend_view.dart';
import '../modules/NAVIGATION_MENUS/home/bindings/home_binding.dart';
import '../modules/NAVIGATION_MENUS/home/create_story/bindings/create_story_binding.dart';
import '../modules/NAVIGATION_MENUS/home/create_story/sub_menus/create_image_story/bindings/create_image_story_binding.dart';
import '../modules/NAVIGATION_MENUS/home/create_story/sub_menus/create_image_story/views/create_image_story_view.dart';
import '../modules/NAVIGATION_MENUS/home/create_story/sub_menus/create_text_story/bindings/create_text_story_binding.dart';
import '../modules/NAVIGATION_MENUS/home/create_story/sub_menus/create_text_story/views/create_text_story_view.dart';
import '../modules/NAVIGATION_MENUS/home/create_story/views/create_story_view.dart';
import '../modules/NAVIGATION_MENUS/home/views/home_view.dart';
import '../modules/NAVIGATION_MENUS/marketplace/bindings/marketplace_binding.dart';
import '../modules/NAVIGATION_MENUS/marketplace/views/marketplace_view.dart';
import '../modules/NAVIGATION_MENUS/notification/bindings/notification_binding.dart';
import '../modules/NAVIGATION_MENUS/notification/views/notification_view.dart';
import '../modules/NAVIGATION_MENUS/user_menu/bindings/user_menu_binding.dart';
import '../modules/NAVIGATION_MENUS/user_menu/profile/bindings/profile_binding.dart';
import '../modules/NAVIGATION_MENUS/user_menu/profile/views/friend_list.dart';
import '../modules/NAVIGATION_MENUS/user_menu/profile/views/profile_view.dart';
import '../modules/NAVIGATION_MENUS/user_menu/views/user_menu_view.dart';
import '../modules/NAVIGATION_MENUS/video/bindings/video_binding.dart';
import '../modules/NAVIGATION_MENUS/video/views/video_view.dart';
import '../modules/about/bindings/about_bindings.dart';
import '../modules/about/views/about_view.dart';
import '../modules/edit_post/bindings/edit_post_binding.dart';
import '../modules/edit_post/views/edit_post_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification_post/bindings/notification_binding.dart';
import '../modules/notification_post/view/notification_post.dart';
import '../modules/other_friend_list/bindings/other_friend_bindings.dart';
import '../modules/other_profile_view/bindings/other_profile_binding.dart';
import '../modules/other_profile_view/views/other_profile_detail_view.dart';
import '../modules/other_profile_view/views/other_profile_view.dart';
import '../modules/shared/create_post/bindings/create_post_bindings.dart';
import '../modules/shared/create_post/view/check_in.dart';
import '../modules/shared/create_post/view/create_post_view.dart';
import '../modules/shared/create_post/view/event_page.dart';
import '../modules/shared/create_post/view/feelings.dart';
import '../modules/shared/create_post/view/gif_page.dart';
import '../modules/shared/create_post/view/tag_people.dart';
import '../modules/shared/detail_post/bindings/detail_post_binding.dart';
import '../modules/shared/detail_post/views/detail_post_view.dart';
import '../modules/shared/reactions/bindings/reactions_binding.dart';
import '../modules/shared/reactions/views/reactions_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/birthday_view.dart';
import '../modules/signup/views/email_view.dart';
import '../modules/signup/views/gender_view.dart';
import '../modules/signup/views/name_view.dart';
import '../modules/signup/views/number_view.dart';
import '../modules/signup/views/password_view.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tab_view/bindings/tab_view_bindings.dart';
import '../modules/tab_view/views/tab_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.STORY_CAROSEL,
      page: () => const StoryCarosel(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.NAME,
      page: () => const NameView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.BIRTHDAY,
      page: () => const BirthdayView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.GENDER,
      page: () => const GenderView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.EMAIL,
      page: () => const EmailView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.NUMBER,
      page: () => const NumberView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD,
      page: () => const PasswordView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO,
      page: () => const VideoView(),
      binding: VideoBinding(),
    ),
    GetPage(
      name: _Paths.FRIEND,
      page: () => const FriendView(),
      binding: FriendBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.MARKETPLACE,
      page: () => const MarketplaceView(),
      binding: MarketplaceBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.TAB,
      page: () => const TabView(),
      binding: TabViewBindings(),
    ),
    GetPage(
      name: _Paths.USER_MENU,
      page: () => const UserMenuView(),
      binding: UserMenuBinding(),
    ),
    GetPage(
      name: _Paths.CREAT_POST,
      page: () => const CreatePostView(),
      binding: CreatePostBindings(),
    ),
    GetPage(
      name: _Paths.TAG_PEOPLE,
      page: () => const TagPeople(),
      binding: CreatePostBindings(),
    ),
    GetPage(
      name: _Paths.FEELINGS,
      page: () => const Feelings(),
      binding: CreatePostBindings(),
    ),
    GetPage(
      name: _Paths.CHECKIN,
      page: () => const CheckIn(),
      binding: CreatePostBindings(),
    ),
    GetPage(
      name: _Paths.GIF,
      page: () => const GifPage(),
      binding: CreatePostBindings(),
    ),
    GetPage(
      name: _Paths.EVENT,
      page: () => const EventPage(),
      binding: CreatePostBindings(),
    ),
    GetPage(
      name: _Paths.REACTIONS,
      page: () => const ReactionsView(),
      binding: ReactionsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_STORY,
      page: () => const CreateStoryView(),
      binding: CreateStoryBinding(),
    ),
    GetPage(
      name: _Paths.OTHERS_PROFILE,
      page: () => const OtherProfileView(),
      binding: OtherProfileBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TEXT_STORY,
      page: () => const CreateTextStoryView(),
      binding: CreateTextStoryBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_IMAGE_STORY,
      page: () => const CreateImageStoryView(),
      binding: CreateImageStoryBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.OTHER_PROFILA_DETAIL,
      page: () => const OtherProfileDetailView(),
      binding: OtherProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_POST,
      page: () => EditPostView(),
      binding: EditPostBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_FRIEND_LIST,
      page: () => const FriendList(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_POST,
      page: () => const DetailPostView(),
      binding: DetailPostBinding(),
    ),
    GetPage(
      name: _Paths.STORY_REACTION,
      page: () =>  StoryReactionView(),
      binding: StoryReactionBinding(),
    ),
    GetPage(
      name: _Paths.OTHER_FRIEND_LIST,
      page: () =>  OtherFriendList(),
      binding: OtherFriendListBindings(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_POST,
      page: () =>  NotificationPost(),
      binding: NotificationBindings(),
    ),
  ];
}
