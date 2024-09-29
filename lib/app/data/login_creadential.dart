
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../config/app_storage.dart';
import '../models/user.dart';
import '../routes/app_pages.dart';

class LoginCredential {
  late final GetStorage _getStorage;
  LoginCredential() {
    _getStorage = GetStorage();
  }

  void handleLoginCredential(Map<String, dynamic> loginResonse) {
    UserModel user = UserModel.fromMap(
        loginResonse['user']); //Retrieving User data from Login Response
    saveUserData(user);
    changeUserAuthState(true);
    saveAccessToken(loginResonse['accessToken']);
    saveRefreshToken(loginResonse['refreshToken']);
  }

//================================================================ User Data ================================================================//
  void saveUserData(UserModel model) {
    _getStorage.write(AppStorage.USER_DATA_KEY, model.toJson());
  }

  UserModel getUserData() {
    UserModel model =
        UserModel.fromJson(_getStorage.read(AppStorage.USER_DATA_KEY));
    return model;
  }

//================================================================ Access Token ================================================================//
  void saveAccessToken(String accessToken) {
    _getStorage.write(AppStorage.ACCESS_TOKEN, accessToken);
  }

  String? getAccessToken() {
    String? accessToken = _getStorage.read(AppStorage.ACCESS_TOKEN);
    return accessToken;
  }
//================================================================ Refresh Token ================================================================//

  void saveRefreshToken(String refreshToken) {
    _getStorage.write(AppStorage.REFRESH_TOKEN, refreshToken);
  }

  String? getRefreshToken() {
    String? refreshToken = _getStorage.read(AppStorage.REFRESH_TOKEN);
    return refreshToken;
  }
//================================================================ Auth State ================================================================//

  void changeUserAuthState(bool isLoggedIn) {
    _getStorage.write(AppStorage.AUTH_STATE_KEY, isLoggedIn);
  }

  bool isUserLoggedIn() {
    bool? isLoggedIn = _getStorage.read(AppStorage.AUTH_STATE_KEY);
    return isLoggedIn ?? false;
  }

  void clearLoginCredential() {
    _getStorage.remove(AppStorage.USER_DATA_KEY);
    _getStorage.remove(AppStorage.AUTH_STATE_KEY);
    _getStorage.remove(AppStorage.REFRESH_TOKEN);
    _getStorage.remove(AppStorage.ACCESS_TOKEN);
  }

  void clearLoginCredentialAndMoveToLogin() {
    _getStorage.remove(AppStorage.USER_DATA_KEY);
    _getStorage.remove(AppStorage.AUTH_STATE_KEY);
    _getStorage.remove(AppStorage.REFRESH_TOKEN);
    _getStorage.remove(AppStorage.ACCESS_TOKEN);
    Get.offAllNamed(Routes.SPLASH);
  }
}
