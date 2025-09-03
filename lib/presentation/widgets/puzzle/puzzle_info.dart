import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:tupange/core/l10n/l10n.dart';

import '../../../core/layout/utils/responsive_layout_builder.dart';
import '../../cubits/game/game_selection_cubit.dart';
import '../../cubits/puzzle_helper/puzzle_helper_cubit.dart';
import '../general/stylized_icon.dart';
import '../general/stylized_text.dart';

class PuzzleInfo extends StatelessWidget {
  const PuzzleInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.read<GameSelectionCubit>().game;

    return ResponsiveLayoutBuilder(
      small: (_, Widget? child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: child!,
      ),
      medium: (_, Widget? child) => child!,
      large: (_, Widget? child) => child!,
      child: (layoutSize) {
        final bool isLarge = layoutSize == ResponsiveLayoutSize.large;
        final bool isSmall = layoutSize == ResponsiveLayoutSize.small;

        return SizedBox(
          width: isSmall ? null : 500.0,
          height: isLarge
              ? 250
              : isSmall
                  ? 160
                  : 180,
          child: Column(
            crossAxisAlignment:
                isLarge ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              // title
              Text(
                game.title!,
                style: TextStyle(
                  fontSize: isLarge ? 48.0 : 32.0,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),

              // gap
              const Spacer(),

              // puzzle optimize label
              context.read<PuzzleHelperCubit>().state.optimized
                  ? Tooltip(
                      message: context.l10n.optimizedDescription,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      textStyle: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14.0,
                        letterSpacing: 1.5,
                        wordSpacing: 2.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const StylizedIcon(
                            icon: FontAwesomeIcons.bolt,
                            color: Colors.redAccent,
                          ),
                          const Gap(12.0),
                          StylizedText(
                            text: context.l10n.optimizedLabel,
                            textColor: Colors.redAccent,
                            strokeWidth: 4.0,
                            offset: 1.5,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
