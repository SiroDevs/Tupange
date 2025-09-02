part of 'playing_bloc.dart';

enum PuzzleAutoSolveState {
  start,
  stop,
}

abstract class PlayingEvent extends Equatable {
  const PlayingEvent();

  @override
  List<Object> get props => [];
}

class PuzzleInitialized extends PlayingEvent {
  const PuzzleInitialized({required this.shufflePuzzle});

  final bool shufflePuzzle;

  @override
  List<Object> get props => [shufflePuzzle];
}

class TileTapped extends PlayingEvent {
  const TileTapped(this.tile);

  final Tile tile;

  @override
  List<Object> get props => [tile];
}

class PuzzleReset extends PlayingEvent {
  const PuzzleReset();
}
