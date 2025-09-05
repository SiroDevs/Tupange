import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../blocs/readying/readying_bloc.dart';
import '../../../core/utils/app_logger.dart';
import '../../../core/constants/app_constants.dart';

part 'puzzle_init_state.dart';

class PuzzleInitCubit extends Cubit<PuzzleInitState> {
  final ReadyingBloc _playingBloc;
  final int _puzzleSize;

  int get _lastTileKey => _puzzleSize * _puzzleSize - 1;

  PuzzleInitCubit(this._puzzleSize, this._playingBloc)
      : super(const PuzzleInitLoading());

  final Map<int, GlobalKey> _globalKeyMap = {};

  GlobalKey getGlobalKey(int tileKey) {
    if (_globalKeyMap.containsKey(tileKey)) return _globalKeyMap[tileKey]!;

    final globalKey = GlobalKey(debugLabel: 'GlobalKey for $tileKey');
    _globalKeyMap[tileKey] = globalKey;
    onInit(tileKey);
    return globalKey;
  }

  void _startAnimating() async {
    await Future.delayed(AppConstants.kMS250);

    if (!isClosed) emit(const PuzzleInitReady());
  }

  void onInit(int tileKey) {
    final hasStarted =
        _playingBloc.state.status == GameStatus.started;

    AppLogger.log('puzzle_init_cubit: onInit: hasStarted: $hasStarted');

    if (tileKey == _lastTileKey) {
      _startAnimating();
    }

    if (hasStarted && tileKey == _lastTileKey - 1) {
      _startAnimating();
    }
  }
}
