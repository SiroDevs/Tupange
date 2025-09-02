import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/puzzle.dart';
import '../../../core/audio/cubit/audio_player_cubit.dart';
import '../../../core/utils/utils.dart';
import '../../../data/models/ticker.dart';
import '../../cubits/dashboard/level_selection_cubit.dart';
import '../../cubits/dashboard/planet_selection_cubit.dart';
import '../../blocs/readying/readying_bloc.dart';
import '../../cubits/planet_puzzle/planet_fact_cubit.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../blocs/timer/timer_bloc.dart';
import '../../cubits/puzzle_helper/puzzle_helper_cubit.dart';
import '../../cubits/puzzle_init/puzzle_init_cubit.dart';
import '../../widgets/puzzle/puzzle_header.dart';
import '../../widgets/puzzle/puzzle_sections.dart';
import '../../blocs/playing/playing_bloc.dart';
import '../../widgets/background/background.dart';

class PlayingPage extends StatelessWidget {
  const PlayingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReadyingBloc(
            secondsToBegin: context.read<LevelSelectionCubit>().puzzleSize,
            ticker: const Ticker(),
          ),
        ),
        BlocProvider(
          create: (context) => PuzzleInitCubit(
            context.read<LevelSelectionCubit>().puzzleSize,
            context.read<ReadyingBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => PlayingBloc(
            context.read<LevelSelectionCubit>().puzzleSize,
            context.read<AudioPlayerCubit>(),
          )..add(const PuzzleInitialized(shufflePuzzle: false)),
        ),
        BlocProvider(
          create: (context) => PuzzleHelperCubit(
            context.read<PlayingBloc>(),
            context.read<AudioPlayerCubit>(),
            optimized: Utils.isOptimizedPuzzle() ||
                context.read<LevelSelectionCubit>().puzzleLevel ==
                    PuzzleLevel.hard,
          ),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(
            planet: context.read<PlanetSelectionCubit>().planet,
          ),
        ),
        BlocProvider(
          create: (_) => TimerBloc(
            ticker: const Ticker(),
          ),
        ),
        BlocProvider(
          create: (_) => PlanetFactCubit(
            planetType: context.read<PlanetSelectionCubit>().planet.type,
            context: context,
          ),
        ),
      ],
      child: const _PuzzleView(),
    );
  }
}

class _PuzzleView extends StatelessWidget {
  const _PuzzleView();

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    // final state = context.select((PlayingBloc bloc) => bloc.state);

    return Background(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              BlocBuilder<PlayingBloc, PlayingState>(
                bloc: context.read<PlayingBloc>(),
                builder: (_, puzzleState) {
                  return theme.puzzleLayoutDelegate.backgroundBuilder(
                    theme,
                    puzzleState,
                  );
                },
              ),

              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      PuzzleHeader(),
                      PuzzleSections(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
