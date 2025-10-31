part of '../home_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  Map<PuzzleLevel, String> _getLevelWidgets(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;

    final map = {
      PuzzleLevel.easy: l10n.easy,
      PuzzleLevel.medium: l10n.medium,
    };

    if (!AppUtils.isOptimizedPuzzle()) {
      map[PuzzleLevel.hard] = l10n.hard;
    }

    return map;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Align(
      alignment: AppConstants.kFOTopCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ResponsiveLayoutBuilder(
            small: (_, Widget? child) => child!,
            medium: (_, Widget? child) => child!,
            large: (_, Widget? child) => child!,
            child: (layoutSize) {
              final bool isSmall = layoutSize == ResponsiveLayoutSize.small;

              return StylizedContainer(
                key: isSmall
                    ? const Key('header_widget_small')
                    : const Key('header_widget_normal'),
                color: const Color(0xffffcc33),
                child: StylizedText(
                  text: l10n.selectionHeading,
                  fontSize: isSmall ? 24.0 : 32.0,
                  strokeWidth: isSmall ? 5.0 : 6.0,
                ),
              );
            },
          ),
          const Gap(30),
          BlocBuilder<LevelSelectionCubit, LevelSelectionState>(
            builder: (context, state) {
              return Semantics(
                label: l10n.levelSelectionLabel,
                child: SegmentedControl(
                  groupValue: state.level,
                  children: _getLevelWidgets(context),
                  onValueChanged:
                      context.read<LevelSelectionCubit>().onNewLevelSelected,
                ),
              );
            },
          ),
          const Gap(25),
          ResponsiveLayoutBuilder(
            small: (_, Widget? child) => child!,
            medium: (_, Widget? child) => child!,
            large: (_, __) => const SizedBox.shrink(),
            child: (_) => const AudioControl(),
          ),
        ],
      ),
    );
  }
}
