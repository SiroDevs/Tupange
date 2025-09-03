import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_assets.dart';
import '../../../core/utils/constants/app_constants.dart';
import '../../../data/models/bubble.dart';

class BubbleWidget extends StatelessWidget {
  final Bubble bubble;
  const BubbleWidget({
    super.key,
    required this.bubble,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: AppConstants.kMS500,
      left: bubble.pos.x.toDouble(),
      top: bubble.pos.y.toDouble(),
      width: bubble.size,
      height: bubble.size,
      child: Transform.rotate(
        angle: bubble.rotation,
        child: Image.asset(
          AppAssets.appIcon,
          height: bubble.size,
          width: bubble.size,
        ),
      ),
    );
  }
}
