import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'app/config/app_constant.dart';
import 'app/config/app_theme.dart';
import 'app/routes/app_pages.dart';

class QuantumPossibilities extends StatelessWidget {
  const QuantumPossibilities({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.APP_NAME,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: lightTheme,
      darkTheme: dartkTheme,
      themeMode: ThemeMode.light,
      builder: EasyLoading.init(),
    );
  }
}
