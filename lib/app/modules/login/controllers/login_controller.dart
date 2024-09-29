import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/api_constant.dart';
import '../../../data/login_creadential.dart';
import '../../../models/api_response.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_communication.dart';
import '../../../utils/snackbar.dart';

class LoginController extends GetxController {
  late final TextEditingController userIdController;
  late final TextEditingController passwordController;
  Rx<bool> obscureText = true.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey();
  late ApiCommunication _apiCommunication;
  late LoginCredential _loginCredential;
  void onPressedLogin() async {
    debugPrint(
        '--Log in response starting point-----------------------------------');
    String userId = userIdController.text;
    String password = passwordController.text;
    if (loginFormKey.currentState!.validate()) {
      final ApiResponse response = await _apiCommunication.doPostRequest(
        enableLoading: true,
        apiEndPoint: 'user-login',
        requestData: {
          'email': userId,
          'password': password,
        },
        isFormData: false,
        responseDataKey: ApiConstant.FULL_RESPONSE,
      );
      if (response.isSuccessful && response.statusCode == 200) {
        showSuccessSnackkbar(message: 'You are successfully logged in');
        Map<String, dynamic> fullResponse =
            response.data as Map<String, dynamic>;
        debugPrint(fullResponse.toString());
        _loginCredential.handleLoginCredential(fullResponse);
        Get.offAllNamed(Routes.TAB);
      } else {
        showErrorSnackkbar(message: response.message ?? 'Login error');
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    userIdController = TextEditingController();
    passwordController = TextEditingController();
    _apiCommunication = ApiCommunication();
    _loginCredential = LoginCredential();
  }

  @override
  void onClose() {
    super.onClose();
    userIdController.dispose();
    passwordController.dispose();
    _apiCommunication.endConnection();
  }
}
