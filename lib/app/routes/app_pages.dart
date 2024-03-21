import 'package:get/get.dart';

import '../modules/audio/bindings/audio_binding.dart';
import '../modules/audio/views/audio_view.dart';
import '../modules/data_syncing/bindings/data_syncing_binding.dart';
import '../modules/data_syncing/views/data_syncing_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/dashboard_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const DashboardView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.AUDIO,
      page: () => const AudioView(),
      binding: AudioBinding(),
    ),
    GetPage(
      name: _Paths.DATA_SYNCING,
      page: () => const DataSyncingView(),
      binding: DataSyncingBinding(),
    ),
  ];
}
