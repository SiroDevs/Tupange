import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../l10n/app_localizations.dart';
import '../../blocs/readying/readying_bloc.dart';
import '../../blocs/timer/timer_bloc.dart';
import '../../layout/utils/responsive_layout_builder.dart';
import '../../blocs/playing/playing_bloc.dart';
import '../../cubits/puzzle_helper/puzzle_helper_cubit.dart';
import '../../cubits/puzzle_init/puzzle_init_cubit.dart';
import '../stylized_button.dart';
import '../stylized_container.dart';
import '../stylized_text.dart';

class PuzzleControl extends StatelessWidget {
  const PuzzleControl({super.key});

  void _onStart(BuildContext context, bool hasStarted) {
    context.read<TimerBloc>().add(const TimerReset());
    context.read<ReadyingBloc>().add(CountdownReset(
          secondsToBegin: hasStarted ? 5 : 3,
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
    _onStart(context, true);
    context
        .read<PlayingBloc>()
        .add(const PuzzleInitialized(shufflePuzzle: false));
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;

    final puzzleInitState =
        context.select((PuzzleInitCubit cubit) => cubit.state);
    final isReady = puzzleInitState is PuzzleInitReady;

    final status = context.select((ReadyingBloc bloc) => bloc.state.status);
    final hasStarted = status == GameStatus.started;
    final isLoading = status == GameStatus.loading;

    final puzzleHelperState =
        context.select((PuzzleHelperCubit cubit) => cubit.state);
    final isAutoSolving = puzzleHelperState.isAutoSolving;

    final text = isAutoSolving
        ? l10n.stop
        : !isReady
            ? l10n.pleaseWait
            : isLoading
                ? l10n.getReady
                : hasStarted
                    ? l10n.autoSolve
                    : l10n.start;

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
              key: Key('puzzle_control_${hasStarted}_${isLoading}_$isReady'),
              onPressed: () {
                if (!isReady || isLoading) return;

                if (hasStarted) {
                  _onAutoSolve(
                    context,
                    isAutoSolving
                        ? PuzzleAutoSolveState.stop
                        : PuzzleAutoSolveState.start,
                  );
                } else {
                  _onStart(context, hasStarted);
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
                if (!hasStarted || isAutoSolving) return;
                _onRestart(context);
              },
              child: StylizedContainer(
                color: !hasStarted || isAutoSolving
                    ? Colors.grey
                    : Colors.greenAccent,
                child: StylizedText(
                  text: l10n.restart,
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
