import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constants/pref_constants.dart';
import '../../../core/di/injectable.dart';
import '../../../data/models/category.dart';
import '../../../data/models/game.dart';
import '../../../data/sources/raw_data.dart';
import '../../../domain/repository/database_repository.dart';
import '../../../domain/repository/preferences_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(_HomeState()) {
    on<FetchData>(_onFetchData);
    on<SaveData>(_onSaveData);
  }

  final _dbRepo = getIt<DatabaseRepository>();
  final _prefsRepo = getIt<PreferencesRepository>();

  void _onFetchData(
    FetchData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoadingState());
    bool isDataLoaded = _prefsRepo.getPrefBool(PrefConstants.isDataLoadedKey);
    if (!isDataLoaded) _initDatabase();

    List<Category> categories = await _dbRepo.fetchCategories();
    List<Game> games = await _dbRepo.fetchGames();
    if (categories.isEmpty || games.isEmpty) {
      _initDatabase();
      categories = await _dbRepo.fetchCategories();
      games = await _dbRepo.fetchGames();
    }

    emit(HomeFetchedState(categories, games));
  }

  void _initDatabase() async {
    for (final category in RawData.categories) {
      await _dbRepo.saveCategory(category: category);
    }

    for (final game in RawData.games) {
      await _dbRepo.saveGame(game: game);
    }
    _prefsRepo.setPrefBool(PrefConstants.isDataLoadedKey, true);
  }

  void _onSaveData(
    SaveData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoadingState());

    await _dbRepo.removeAllCategories();
    await _dbRepo.removeAllGames();

    for (final category in event.categories) {
      await _dbRepo.saveCategory(category: category);
    }

    for (final game in event.games) {
      await _dbRepo.saveGame(game: game);
    }

    await Future<void>.delayed(const Duration(seconds: 10));
    _prefsRepo.setPrefBool(PrefConstants.isOnboardedKey, true);

    emit(const HomeSuccessState());
  }
  
}
