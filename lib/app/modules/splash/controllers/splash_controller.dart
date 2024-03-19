import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () async {
      Get.offAndToNamed(Routes.LOGIN);
    });
  }
}
