// lib/core/utils/gaming_utils.dart
import 'dart:math';

import '../../data/models/position.dart';
import '../../data/models/puzzle.dart';
import '../../data/models/tile.dart';

class GamingUtils {
  const GamingUtils._();

  static Puzzle generatePuzzle(
    int size, {
    bool shuffle = true,
    Random? random,
  }) {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    for (var y = 0; y < size; y++) {
      for (var x = 0; x < size; x++) {
        if (x == size && y == size) {
          correctPositions.add(whitespacePosition);
          currentPositions.add(whitespacePosition);
        } else {
          final position = Position(x: x, y: y);
          correctPositions.add(position);
          currentPositions.add(position);
        }
      }
    }

    if (shuffle) {
      currentPositions.shuffle(random);
    }

    var tiles = getTileListFromPositions(
      size: size,
      currentPositions: currentPositions,
      correctPositions: correctPositions,
    );
    var puzzle = Puzzle(tiles: tiles);

    if (shuffle) {
      while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
        currentPositions.shuffle(random);
        tiles = getTileListFromPositions(
          size: size,
          currentPositions: currentPositions,
          correctPositions: correctPositions,
        );
        puzzle = Puzzle(tiles: tiles);
      }
    }

    return puzzle;
  }

  static List<Tile> getTileListFromPositions({
    required int size,
    required List<Position> currentPositions,
    required List<Position> correctPositions,
  }) {
    final whitespacePosition = Position(x: size - 1, y: size - 1);
    final n = size * size;

    return [
      for (int i = 0; i < n; i++)
        if (i == n - 1)
          Tile(
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i],
            isWhitespace: true,
            puzzleSize: size,
          )
        else
          Tile(
            value: i,
            correctPosition: correctPositions[i],
            currentPosition: currentPositions[i],
            puzzleSize: size,
          )
    ];
  }
}
