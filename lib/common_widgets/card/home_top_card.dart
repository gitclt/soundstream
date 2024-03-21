import 'package:flutter/widgets.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

// ignore: must_be_immutable
class HomeHeader extends StatelessWidget {
  final Widget homecard;
  final double? height;
  Widget? feild;
  HomeHeader({
    super.key,
    required this.homecard,
    this.feild,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            gradient: primaryColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          child: feild,
        ),
        Positioned(left: 20, right: 20, top: 160, child: homecard)
      ],
    );
  }
}
