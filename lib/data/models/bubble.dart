import 'package:flutter/material.dart';

import '../../presentation/widgets/background/bubble_widget.dart';
import 'position.dart';

class Bubble {
  final int value;
  final Position pos;
  final double size;
  final double rotation;

  Bubble({
    required this.value,
    required this.pos,
    required this.size,
    required this.rotation,
  });

  Widget get widget => BubbleWidget(
        bubble: this,
        key: ValueKey(value),
      );
}
