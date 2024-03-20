import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/common_widgets/app_bar/home_appbar.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(label: 'Profile'),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const ProfileImgWidget(),
              const SizedBox(
                height: 10,
              ),
              colorText('Rajesh Raj', 24,
                  color: const Color(0xFF4D02E0), fontWeight: FontWeight.w700),
              const SizedBox(
                height: 30,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(width: 0.5),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 240, 235, 235),
                            blurRadius: 3.0,
                            spreadRadius: 3),
                      ]),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ProfileRow(
                          label: 'Name',
                          details: 'Rajesh Raj',
                        ),
                        Divider(),
                        ProfileRow(
                          label: 'City',
                          details: 'Calicut',
                        ),
                        Divider(),
                        ProfileRow(
                          label: 'Vehicle No.',
                          details: 'KL11 N 6789',
                        ),
                        Divider(),
                        ProfileRow(
                          label: 'Mobile No.',
                          details: '9709332288',
                        ),
                        Divider(),
                        ProfileRow(
                          label: 'Email Id',
                          details: 'rajeshraj@gmail.com',
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  controller.logOut();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(width: 0.5),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 240, 235, 235),
                            blurRadius: 3.0,
                            spreadRadius: 3),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        blackText('Logout', 16),
                        svgWidget('assets/svg/logout.svg')
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class ProfileRow extends StatelessWidget {
  final String label, details;
  const ProfileRow({
    super.key,
    required this.label,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          blackText(
            label,
            16,
          ),
          blackText(details, 16, fontWeight: FontWeight.w500)
        ],
      ),
    );
  }
}

class ProfileImgWidget extends StatelessWidget {
  const ProfileImgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(fit: StackFit.loose, clipBehavior: Clip.none, children: [
        Image.asset("assets/image/profile.png"),
        Positioned(
            bottom: 4,
            right: -4,
            child: svgWidget('assets/svg/edit_profile.svg'))
      ]),
    );
  }
}
