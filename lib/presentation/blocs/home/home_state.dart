part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _HomeState;

  const factory HomeState.loaded(List<Orbit> orbits) = HomeLoadedState;

  const factory HomeState.loading() = HomeLoadingState;

  const factory HomeState.success() = HomeSuccessState;

  const factory HomeState.fetched(
    List<Category> categories,
    List<Game> games,
  ) = HomeFetchedState;

  const factory HomeState.failure(String feedback) = HomeFailureState;
}
