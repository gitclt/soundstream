import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:sound_stream_flutter_app/common_widgets/button/gradient_button.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/common_widgets/textfeild/login_textfeild.dart';

import '../../../../common_widgets/app_bar/home_appbar.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(label: 'App Bar'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blackText('Sign In', 28, fontWeight: FontWeight.w700),
              const SizedBox(
                height: 15,
              ),
              const LoginTextField(
                // prefixIcon: ,
                hintText: 'Enter your Mobile Number',
              ),
              const SizedBox(
                height: 15,
              ),
              const LoginTextField(
                hintText: 'Enter your Vehicle Number',
              ),
              const SizedBox(
                height: 25,
              ),
              CommonButtonWidget(
                label: 'Sign in',
                onClick: () {
                  Get.offAndToNamed(Routes.HOME);
                },
              )
            ],
          ),
        ));
  }
}
