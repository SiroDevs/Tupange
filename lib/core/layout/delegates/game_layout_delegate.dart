import 'package:flutter/material.dart';

import '../../../data/models/tile.dart';
import '../../../presentation/widgets/controls/puzzle_control.dart';
import '../../../presentation/widgets/puzzle/game_puzzle_tile.dart';
import '../../../presentation/widgets/puzzle/game_whitespace_tile.dart';
import '../../../presentation/widgets/puzzle/puzzle_board.dart';
import '../../../presentation/widgets/puzzle/puzzle_info.dart';
import '../../../presentation/widgets/puzzle/puzzle_stats.dart';
import '../utils/responsive_gap.dart';
import 'puzzle_layout_delegate.dart';

abstract class BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 512;
}

class GameLayoutDelegate extends PuzzleLayoutDelegate {

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 48,
          medium: 32,
          large: 96,
        ),
        PuzzleBoard(tiles: tiles),
        const ResponsiveGap(
          small: 48,
          medium: 32,
          large: 96,
        ),
      ],
    );
  }

  @override
  Widget controlBuilder() {
    return const PuzzleControl();
  }

  @override
  Widget infoBuilder() {
    return const PuzzleInfo();
  }

  @override
  Widget statsBuilder() {
    return const PuzzleStats();
  }

  @override
  Widget tileBuilder(Tile tile) {
    return ReadyingTile(key: ValueKey(tile.value), tile: tile);
  }

  @override
  Widget whitespaceTileBuilder(Tile tile) {
    return GameWhitespaceTile(tile: tile);
  }

  @override
  List<Object?> get props => [];
}
