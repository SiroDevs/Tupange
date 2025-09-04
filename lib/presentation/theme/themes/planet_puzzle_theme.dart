import '../../layout/delegates/puzzle_layout_delegate.dart';
import '../../layout/planet_puzzle/planet_puzzle_layout_delegate.dart';
import 'puzzle_theme.dart';

abstract class PlanetPuzzleTheme extends PuzzleTheme {
  const PlanetPuzzleTheme();

  @override
  String get name => 'Planet';

  @override
  PuzzleLayoutDelegate get puzzleLayoutDelegate => PlanetPuzzleLayoutDelegate();
}
