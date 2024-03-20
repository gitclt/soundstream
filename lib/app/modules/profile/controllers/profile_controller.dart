import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';

class ProfileController extends GetxController {
 
  void logOut() async {
    // dynamic returnResponse =
    //     await openDialog('Logout', 'Are you sure you want to Logout ?');
    // if (returnResponse == true) {
    //   final prefs = await SharedPreferences.getInstance();
    //   prefs.clear();
    //   DatabaseHelper().clearDatabase();
      Get.offAllNamed(Routes.SPLASH);
    }
  }

