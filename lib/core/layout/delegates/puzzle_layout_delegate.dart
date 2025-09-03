import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/models/tile.dart';

abstract class PuzzleLayoutDelegate extends Equatable {
  const PuzzleLayoutDelegate();

  Widget infoBuilder();

  Widget statsBuilder();

  Widget controlBuilder();

  Widget boardBuilder(int size, List<Widget> tiles);

  Widget tileBuilder(Tile tile);

  Widget whitespaceTileBuilder(Tile tile);
}
