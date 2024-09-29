import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'color.dart';

void showLoader() {
  EasyLoading.show(status: 'Loading...');
}

void configLoader() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.white
    ..indicatorColor = PRIMARY_COLOR
    ..textColor = PRIMARY_COLOR;
}

void dismissLoader() {
  EasyLoading.dismiss();
}
