part of 'playing_bloc.dart';

enum PlayingStatus { incomplete, complete }

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

class PlayingState extends Equatable {
  const PlayingState({
    this.puzzle = const Puzzle(tiles: []),
    this.playingStatus = PlayingStatus.incomplete,
    this.tileMovementStatus = TileMovementStatus.nothingTapped,
    this.numberOfCorrectTiles = 0,
    this.numberOfMoves = 0,
    this.lastTappedTile,
  });

  final Puzzle puzzle;
  final PlayingStatus playingStatus;
  final TileMovementStatus tileMovementStatus;
  final Tile? lastTappedTile;
  final int numberOfCorrectTiles;
  int get numberOfTilesLeft => puzzle.tiles.length - numberOfCorrectTiles - 1;
  final int numberOfMoves;

  PlayingState copyWith({
    Puzzle? puzzle,
    PlayingStatus? playingStatus,
    TileMovementStatus? tileMovementStatus,
    int? numberOfCorrectTiles,
    int? numberOfMoves,
    Tile? lastTappedTile,
    bool? isAutoSolving,
    bool? showHelp,
  }) {
    return PlayingState(
      puzzle: puzzle ?? this.puzzle,
      playingStatus: playingStatus ?? this.playingStatus,
      tileMovementStatus: tileMovementStatus ?? this.tileMovementStatus,
      numberOfCorrectTiles: numberOfCorrectTiles ?? this.numberOfCorrectTiles,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
      lastTappedTile: lastTappedTile ?? this.lastTappedTile,
    );
  }

  @override
  List<Object?> get props => [
        puzzle,
        playingStatus,
        tileMovementStatus,
        numberOfCorrectTiles,
        numberOfMoves,
        lastTappedTile,
      ];
}
