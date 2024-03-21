import 'package:get/get.dart';

import '../controllers/data_syncing_controller.dart';

class DataSyncingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataSyncingController>(
      () => DataSyncingController(),
    );
  }
}
