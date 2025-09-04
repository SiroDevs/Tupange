import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/tile.dart';
import '../../blocs/playing/playing_bloc.dart';
import '../../blocs/readying/readying_bloc.dart';
import '../../blocs/timer/timer_bloc.dart';
import '../../cubits/puzzle_helper/puzzle_helper_cubit.dart';
import '../../cubits/puzzle_init/puzzle_init_cubit.dart';

class PuzzleKeyboardHandler extends StatefulWidget {
  final Widget child;

  const PuzzleKeyboardHandler({
    super.key,
    required this.child,
  });

  @override
  PuzzleKeyboardHandlerState createState() => PuzzleKeyboardHandlerState();
}

class PuzzleKeyboardHandlerState extends State<PuzzleKeyboardHandler> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onstart(bool hasstarted) {
    context.read<TimerBloc>().add(const TimerReset());
    context.read<ReadyingBloc>().add(CountdownReset(
          secondsToBegin: hasstarted ? 5 : 3,
        ));
  }

  void _onAutoSolve(PuzzleAutoSolveState autoSolveState) {
    if (autoSolveState == PuzzleAutoSolveState.start) {
      context.read<PuzzleHelperCubit>().startAutoSolver();
    } else {
      context.read<PuzzleHelperCubit>().stopAutoSolver();
    }
  }

  void _onRestart() {
    _onstart(true);
    context
        .read<PlayingBloc>()
        .add(const PuzzleInitialized(shufflePuzzle: false));
  }

  /// For the puzzle, the following keyboard events are important
  /// [Space] start / Auto Solve / Stop
  /// [R] key -> restart
  /// [V] key -> toggle visibility of helpers (numbers)
  /// [UpArrow] key -> move whitespace up
  /// [DownArrow] key -> move whitespace down
  /// [LeftArrow] key -> move whitespace left
  /// [RightArrow] key -> move whitespace right
  /// [esc] key -> move back to solar system
  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final physicalKey = event.data.physicalKey;

      final puzzleInitState = context.read<PuzzleInitCubit>().state;
      final planetPlayingState = context.read<ReadyingBloc>().state;

      final isAutoSolving =
          context.read<PuzzleHelperCubit>().state.isAutoSolving;

      final isReady = puzzleInitState is PuzzleInitReady;
      final hasstarted = planetPlayingState.status == ReadyingStatus.started;
      final isLoading = planetPlayingState.status == ReadyingStatus.loading;

      final puzzleBloc = context.read<PlayingBloc>();

      final puzzle = puzzleBloc.state.puzzle;
      final puzzleIncomplete =
          puzzleBloc.state.playingStatus == PlayingStatus.incomplete;

      final canPress = hasstarted && puzzleIncomplete && !isAutoSolving;

      Tile? tile;

      if (physicalKey == PhysicalKeyboardKey.space) {
        /// do not do anything if
        /// 1. puzzle is not ready
        /// 2. puzzle is loading
        if (!isReady || isLoading) return;

        if (hasstarted && puzzleIncomplete) {
          _onAutoSolve(
            isAutoSolving
                ? PuzzleAutoSolveState.stop
                : PuzzleAutoSolveState.start,
          );
        } else {
          _onstart(hasstarted);
        }
      } else if (physicalKey == PhysicalKeyboardKey.keyR) {
        if (!hasstarted || isAutoSolving) return;
        _onRestart();
      } else if (physicalKey == PhysicalKeyboardKey.keyV) {
        context.read<PuzzleHelperCubit>().onHelpToggle();
      } else if (physicalKey == PhysicalKeyboardKey.arrowUp) {
        tile = puzzle.getTileRelativeToGameWhitespaceTile(const Offset(0, -1));
      } else if (physicalKey == PhysicalKeyboardKey.arrowDown) {
        tile = puzzle.getTileRelativeToGameWhitespaceTile(const Offset(0, 1));
      } else if (physicalKey == PhysicalKeyboardKey.arrowRight) {
        tile = puzzle.getTileRelativeToGameWhitespaceTile(const Offset(1, 0));
      } else if (physicalKey == PhysicalKeyboardKey.arrowLeft) {
        tile = puzzle.getTileRelativeToGameWhitespaceTile(const Offset(-1, 0));
      } else if (physicalKey == PhysicalKeyboardKey.escape) {
        Navigator.pop(context);
      }

      if (tile != null && canPress) {
        context.read<PlayingBloc>().add(TileTapped(tile));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      child: Builder(builder: (context) {
        if (!_focusNode.hasFocus) {
          FocusScope.of(context).requestFocus(_focusNode);
        }
        return widget.child;
      }),
    );
  }
}
