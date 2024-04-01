import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/dashboard_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}
