import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioController extends GetxController with GetTickerProviderStateMixin {
  late TabController mainController;
  var selectedIndex = 0.obs;
  var isIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();

    mainController = TabController(length: 3, vsync: this);
  }
}
