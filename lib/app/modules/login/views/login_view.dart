import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/common_widgets/button/gradient_button.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/common_widgets/textfeild/login_textfeild.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 220,
              // padding: const EdgeInsets.fromLTRB(96, 75.61, 94.91, 26.49),
              decoration: BoxDecoration(
                gradient: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: Border.all(width: 0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  "assets/logo/sound_logo.png",
                  height: 80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    blackText('Sign In', 28, fontWeight: FontWeight.w700),
                    const SizedBox(
                      height: 15,
                    ),
                    LoginTextField(
                      keytype: TextInputType.phone,
                      prefixIcon: svgWidget('assets/svg/smartphone.svg'),
                      hintText: 'Enter your Mobile Number',
                      textEditingController: controller.mobileController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Mobile Number';
                        }
                        if (value!.toString().length < 10) {
                          return 'Invalid mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    LoginTextField(
                      prefixIcon: svgWidget('assets/svg/vehicle.svg'),
                      hintText: 'Enter your Vehicle Number',
                      textEditingController: controller.vehicleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Vehicle Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(
                      () => CommonButtonWidget(
                        label: 'Sign in',
                        isLoading: controller.isLoading.value,
                        onClick: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.login();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: TextButton(
      //     onPressed: () {},
      //     child: const Text('Don’t have an account? Sign Up')),
    );
  }
}
