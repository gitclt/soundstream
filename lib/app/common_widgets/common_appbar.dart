import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appText;

  const CommonAppBar({super.key, required this.appText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Get.back();
        },
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: primaryColor,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      title: Text(
        appText,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
