import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/tile.dart';
import '../../../core/utils/app_logger.dart';
import '../../blocs/readying/readying_bloc.dart';
import 'game_tile.dart';

class GameWhitespaceTile extends StatelessWidget {
  final Tile tile;

  const GameWhitespaceTile({super.key, required this.tile});

  @override
  Widget build(BuildContext context) {
    final status = context.select((ReadyingBloc bloc) => bloc.state.status);
    final hasStarted = status == GameStatus.started;

    AppLogger.log('GameWhitespaceTile: hasStarted $hasStarted');

    return hasStarted
        ? const SizedBox.shrink()
        : GameTile(
            key: ValueKey(tile.value),
            tile: tile,
          );
  }
}
