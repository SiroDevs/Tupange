
import 'package:flutter/material.dart';

import '../../../presentation/theme/themes/puzzle_theme.dart';
import '../utils/responsive_layout_builder.dart';

class LandscapeWidget extends StatelessWidget {
  final PuzzleTheme theme;
  const LandscapeWidget({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      key: const Key('game_landscape'),
      small: (_, Widget? child) => Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset(
          theme.backgroundAsset,
          height: 120.0,
          fit: BoxFit.cover,
        ),
      ),
      medium: (_, Widget? child) => child!,
      large: (_, Widget? child) => child!,
      child: (_) => Align(
        alignment: Alignment.bottomCenter,
        child: Builder(builder: (context) {
          return Image.asset(
            theme.backgroundAsset,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          );
        }),
      ),
    );
  }
}
