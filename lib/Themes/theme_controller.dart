import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDark.value = Get.isDarkMode;
  }

  void changeTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
