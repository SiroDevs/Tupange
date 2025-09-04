import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_utils.dart';
import '../../../data/models/tile.dart';
import '../../blocs/readying/readying_bloc.dart';
import 'game_puzzle_tile.dart';

class GameWhitespaceTile extends StatelessWidget {
  final Tile tile;

  const GameWhitespaceTile({super.key, required this.tile});

  @override
  Widget build(BuildContext context) {
    final status = context.select((ReadyingBloc bloc) => bloc.state.status);
    final hasstarted = status == ReadyingStatus.started;

    AppUtils.logger('GameWhitespaceTile: hasstarted $hasstarted');

    return hasstarted
        ? const SizedBox.shrink()
        : ReadyingTile(
            key: ValueKey(tile.value),
            tile: tile,
          );
  }
}
