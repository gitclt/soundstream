import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/dashboard_controller.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/home_trip_controller.dart';
import 'package:sound_stream_flutter_app/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<HomeTripController>(
      () => HomeTripController(),
    );
    Get.put(DashboardController());
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
