import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../enum/singing_character.dart';
import '../../../models/api_response.dart';
import '../../../models/gender.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_communication.dart';
import '../../../utils/snackbar.dart';

class SignupController extends GetxController {
  late final ApiCommunication _apiCommunication;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController passwordController;

  final GlobalKey<FormState> nameFormKey = GlobalKey();
  final GlobalKey<FormState> emailFormKey = GlobalKey();
  final GlobalKey<FormState> mobileFormKey = GlobalKey();
  final GlobalKey<FormState> passwordFormKey = GlobalKey();

  Rx<DateTime> selectedDate = DateTime.now().obs;

  Rx<double> year = 0.0.obs;
  Rx<List<GenderModel>> genderList = Rx([]);

  Rx<Gender> character = Gender.Male.obs;
  Rx<GenderModel?> selectedGender = Rx(null);

  void onSelectDate(DateTime dateTime) {
    selectedDate.value = dateTime;
    Duration difference = DateTime.now().difference(selectedDate.value);
    year.value = difference.inDays / 365;
  }

  void getGenders() async {
    final ApiResponse apiResponse = await _apiCommunication.doGetRequest(
      apiEndPoint: 'gender',
      responseDataKey: 'allGender',
    );
    if (apiResponse.isSuccessful) {
      genderList.value = (apiResponse.data as List)
          .map((element) => GenderModel.fromMap(element))
          .toList();
    } else {
      // debugPrint('Test');
    }
  }

  void onClickNextFromGender() {
    if (selectedGender.value == null) {
      showWarningSnackkbar(message: 'Please select gender first');
    } else {
      Get.toNamed(Routes.EMAIL);
    }
  }

  void signUp() async {
    if (passwordFormKey.currentState!.validate()) {
      final ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'signup',
        requestData: {
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phone': mobileController.text,
          'gender': selectedGender.value?.id,
          'day': selectedDate.value.day,
          'month': selectedDate.value.month,
          'year': selectedDate.value.year,
          'isAccept': true,
        },
      );
      if (apiResponse.isSuccessful) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        // debugPrint('');
      }
    }
  }

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    // mobileController.text = '+880';
    passwordController = TextEditingController();
    _apiCommunication = ApiCommunication();
    onSelectDate(DateTime(2000, 01, 01));
    super.onInit();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    _apiCommunication.endConnection();
    super.onClose();
  }
}
