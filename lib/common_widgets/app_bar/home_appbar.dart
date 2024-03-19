import 'package:flutter/material.dart';

import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final bool? visibility;
  final Widget? widget;
  const CommonAppBar(
      {super.key, required this.label, this.visibility = true, this.widget});

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      // actions: <Widget>[
      //   IconButton(icon: svgWidget('assets/svg/Bell.svg'), onPressed: () => {})
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
