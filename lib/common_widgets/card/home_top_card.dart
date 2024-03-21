import 'package:flutter/widgets.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class HomeHeader extends StatelessWidget {
  final Widget homecard;
  Widget? feild;
  HomeHeader({
    super.key,
    required this.homecard,
    this.feild,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: primaryColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          child: feild,
        ),
        Positioned(left: 20, right: 20, top: 150, child: homecard)
      ],
    );
  }
}
