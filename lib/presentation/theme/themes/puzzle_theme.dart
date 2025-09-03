import '../../../core/layout/delegates/game_layout_delegate.dart';
import '../../../core/layout/delegates/puzzle_layout_delegate.dart';
import '../../../core/utils/constants/app_assets.dart';

class PuzzleTheme {
  final String name;
  final String backgroundAsset;
  final PuzzleLayoutDelegate puzzleLayoutDelegate;
  final String assetForTile;
  final String placeholderAssetForTile;
  final String placeholderThumbnail;

  const PuzzleTheme({
    required this.name,
    required this.backgroundAsset,
    required this.puzzleLayoutDelegate,
    required this.assetForTile,
    required this.placeholderAssetForTile,
    required this.placeholderThumbnail,
  });

  PuzzleTheme copyWith({
    String? name,
    String? backgroundAsset,
    PuzzleLayoutDelegate? puzzleLayoutDelegate,
    String? assetForTile,
    String? placeholderAssetForTile,
    String? placeholderThumbnail,
  }) {
    return PuzzleTheme(
      name: name ?? this.name,
      backgroundAsset: backgroundAsset ?? this.backgroundAsset,
      puzzleLayoutDelegate: puzzleLayoutDelegate ?? this.puzzleLayoutDelegate,
      assetForTile: assetForTile ?? this.assetForTile,
      placeholderAssetForTile:
          placeholderAssetForTile ?? this.placeholderAssetForTile,
      placeholderThumbnail: placeholderThumbnail ?? this.placeholderThumbnail,
    );
  }
}

class GamingPuzzleTheme extends PuzzleTheme {
  GamingPuzzleTheme()
      : super(
          name: 'Gaming',
          backgroundAsset: AppAssets.nairobiImg,
          puzzleLayoutDelegate: GameLayoutDelegate(),
          assetForTile: AppAssets.appIcon,
          placeholderAssetForTile: AppAssets.appIcon,
          placeholderThumbnail: AppAssets.appIcon,
        );
}
