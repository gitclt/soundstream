import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/home_controller.dart';

import '../controllers/audio_controller.dart';

class AudioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioController>(
      () => AudioController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
