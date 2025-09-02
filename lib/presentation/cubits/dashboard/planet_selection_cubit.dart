import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/planet.dart';
import '../../views/playing/playing_page.dart';
import '../../../core/utils/app_logger.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/utils.dart';
import 'level_selection_cubit.dart';

part 'planet_selection_state.dart';

class PlanetSelectionCubit extends Cubit<PlanetSelectionState> {
  final LevelSelectionCubit _levelSelectionCubit;
  final BuildContext _context;

  PlanetSelectionCubit(this._levelSelectionCubit, this._context)
      : super(NoPlanetSelected());

  late Planet _planet;

  Planet get planet => _planet;

  void onPlanetSelected(Planet planet) async {
    _planet = planet;

    AppLogger.log(
      'PlanetSelectionCubit tapped: $planet: level: ${_levelSelectionCubit.state.level}',
    );

    final page = await Utils.buildPageAsync(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _levelSelectionCubit),
          BlocProvider.value(value: this),
        ],
        child: const PlayingPage(key: Key('puzzle-page')),
      ),
    );

    await Navigator.push(
      _context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        transitionDuration: AppConstants.kMS800,
      ),
    );
  }
}
