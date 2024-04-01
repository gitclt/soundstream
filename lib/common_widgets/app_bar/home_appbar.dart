import 'package:flutter/material.dart';

import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final bool? visibility;
  final Widget? widget;
  final Function? ontap;
  const CommonAppBar(
      {super.key,
      required this.label,
      this.visibility = true,
      this.widget,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      flexibleSpace: Container(
        // height: 200,
        decoration: BoxDecoration(
          gradient: primaryColor,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      leading: Visibility(
          visible: visibility!,
          child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                ontap!();
              })),
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
