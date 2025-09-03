import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/layout/utils/responsive_layout_builder.dart';
import '../../blocs/puzzle/puzzle_bloc.dart';
import '../../blocs/game/game_puzzle_bloc.dart';
import '../../blocs/timer/timer_bloc.dart';
import '../../cubits/puzzle_helper/puzzle_helper_cubit.dart';
import '../../cubits/puzzle_init/puzzle_init_cubit.dart';
import '../general/stylized_button.dart';
import '../general/stylized_container.dart';
import '../general/stylized_text.dart';

class PuzzleControl extends StatelessWidget {
  const PuzzleControl({super.key});

  void _onstart(BuildContext context, bool hasstarted) {
    context.read<TimerBloc>().add(const TimerReset());
    context.read<GamePuzzleBloc>().add(PlanetCountdownReset(
          secondsToBegin: hasstarted ? 5 : 3,
        ));
  }

  void _onAutoSolve(BuildContext context, PuzzleAutoSolveState autoSolveState) {
    if (autoSolveState == PuzzleAutoSolveState.start) {
      context.read<PuzzleHelperCubit>().startAutoSolver();
    } else {
      context.read<PuzzleHelperCubit>().stopAutoSolver();
    }
  }

  void _onRestart(BuildContext context) {
    _onstart(context, true);
    context
        .read<PuzzleBloc>()
        .add(const PuzzleInitialized(shufflePuzzle: false));
  }

  @override
  Widget build(BuildContext context) {
    final puzzleInitState =
        context.select((PuzzleInitCubit cubit) => cubit.state);
    final isReady = puzzleInitState is PuzzleInitReady;

    final status = context.select((GamePuzzleBloc bloc) => bloc.state.status);
    final hasstarted = status == GamePuzzleStatus.started;
    final isLoading = status == GamePuzzleStatus.loading;

    final puzzleHelperState =
        context.select((PuzzleHelperCubit cubit) => cubit.state);
    final isAutoSolving = puzzleHelperState.isAutoSolving;

    final text = isAutoSolving
        ? context.l10n.stop
        : !isReady
            ? context.l10n.pleaseWait
            : isLoading
                ? context.l10n.getReady
                : hasstarted
                    ? context.l10n.autoSolve
                    : context.l10n.start;

    return ResponsiveLayoutBuilder(
      small: (_, Widget? child) => child!,
      medium: (_, Widget? child) => child!,
      large: (_, Widget? child) => child!,
      child: (layoutSize) {
        final isLarge = layoutSize == ResponsiveLayoutSize.large;

        return Row(
          key: Key(isLarge.toString()),
          mainAxisSize: MainAxisSize.min,
          children: [
            // auto solve / pause (pause auto solve) / start
            StylizedButton(
              key: Key('puzzle_control_${hasstarted}_${isLoading}_$isReady'),
              onPressed: () {
                if (!isReady || isLoading) return;

                if (hasstarted) {
                  _onAutoSolve(
                    context,
                    isAutoSolving
                        ? PuzzleAutoSolveState.stop
                        : PuzzleAutoSolveState.start,
                  );
                } else {
                  _onstart(context, hasstarted);
                }
              },
              child: StylizedContainer(
                color: isAutoSolving
                    ? Colors.redAccent
                    : !isReady || isLoading
                        ? Colors.grey
                        : Colors.greenAccent,
                child: StylizedText(
                  text: text,
                  fontSize: isLarge ? 24.0 : 20.0,
                ),
              ),
            ),

            isLarge ? const Gap(38.0) : const Gap(32.0),

            // restart
            StylizedButton(
              onPressed: () {
                if (!hasstarted || isAutoSolving) return;
                _onRestart(context);
              },
              child: StylizedContainer(
                color: !hasstarted || isAutoSolving
                    ? Colors.grey
                    : Colors.greenAccent,
                child: StylizedText(
                  text: context.l10n.restart,
                  fontSize: isLarge ? 24.0 : 20.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
