import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/gaming_utils..dart';
import '../../../data/models/puzzle.dart';
import '../../../data/models/tile.dart';
import '../../cubits/audio/audio_player_cubit.dart';
import '../../widgets/general/shake_animator.dart';

part 'playing_event.dart';
part 'playing_state.dart';

class PlayingBloc extends Bloc<PlayingEvent, PlayingState> {
  final AudioPlayerCubit _audioPlayerCubit;
  final int _size;
  int get size => _size;

  final Random? random;

  final Map<int, ShakeAnimatorController> _shakeControllers = {};

  bool _isAutoSolving = false;

  void onAutoSolvingstarted() {
    _isAutoSolving = true;
  }

  void onAutoSolvingStopped() {
    _isAutoSolving = false;
  }

  PlayingBloc(this._size, this._audioPlayerCubit, {this.random})
      : super(const PlayingState()) {
    on<PlayingInitialized>(_onPlayingInitialized);
    on<TileTapped>(_onTileTapped);
    on<PlayingReset>(_onPlayingReset);
  }

  ShakeAnimatorController getShakeControllerFor(int tileKey) {
    if (_shakeControllers.containsKey(tileKey)) {
      return _shakeControllers[tileKey]!;
    }

    final controller = ShakeAnimatorController();
    _shakeControllers[tileKey] = controller;
    return controller;
  }

  void _notifyShakeAnimation(Tile tile) {
    final whitespacePos = state.puzzle.getGameWhitespaceTile().currentPosition;
    final tilePos = tile.currentPosition;

    final diff = tilePos - whitespacePos;
    final sign = diff.x * diff.y;

    ShakeDirection direction = ShakeDirection.diagonal;

    if (sign < 0) {
      direction = ShakeDirection.oppositeDiagonal;
    }

    AppUtils.logger('_notifyShakeAnimation: shakeDirection: $direction');

    _shakeControllers[tile.value]!.shake(direction);
  }

  void _onPlayingInitialized(
    PlayingInitialized event,
    Emitter<PlayingState> emit,
  ) {
    final puzzle = GamingUtils.generatePuzzle(
      _size,
      shuffle: event.shufflePuzzle,
      random: random,
    );
    emit(
      PlayingState(
        puzzle: puzzle,
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
      ),
    );
  }

  void _onTileTapped(
    TileTapped event,
    Emitter<PlayingState> emit,
  ) {
    final tappedTile = event.tile;
    final isPuzzleIncomplete = state.playingStatus == PlayingStatus.incomplete;
    final isTileMovable = state.puzzle.isTileMovable(tappedTile);

    // play audio if tile is movable
    // do not play the general tile tap audio if auto solving
    if (isTileMovable && !_isAutoSolving) {
      _audioPlayerCubit.tileTappedAudio(tappedTile.value);
    }

    if (isPuzzleIncomplete && isTileMovable) {
      final mutablePuzzle = Puzzle(tiles: [...state.puzzle.tiles]);
      final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
      if (puzzle.isComplete()) {
        AppUtils.logger('PlayingBloc: puzzle.isComplete()');
        emit(
          state.copyWith(
            puzzle: puzzle.sort(),
            playingStatus: PlayingStatus.complete,
            tileMovementStatus: TileMovementStatus.moved,
            numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
            numberOfMoves: state.numberOfMoves + 1,
            lastTappedTile: tappedTile,
          ),
        );
      } else {
        emit(
          state.copyWith(
            puzzle: puzzle.sort(),
            tileMovementStatus: TileMovementStatus.moved,
            numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
            numberOfMoves: state.numberOfMoves + 1,
            lastTappedTile: tappedTile,
          ),
        );
      }
    } else {
      _notifyShakeAnimation(tappedTile);

      _audioPlayerCubit.tileTappedAudio(tappedTile.value, isError: true);

      emit(
        state.copyWith(
          tileMovementStatus: TileMovementStatus.cannotBeMoved,
        ),
      );
    }
  }

  void _onPlayingReset(
    PlayingReset event,
    Emitter<PlayingState> emit,
  ) {
    final puzzle = GamingUtils.generatePuzzle(_size);
    emit(
      PlayingState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
      ),
    );
  }
}
