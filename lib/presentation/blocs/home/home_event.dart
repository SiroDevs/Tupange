part of 'home_bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.fetch() = FetchData;

  const factory HomeEvent.save(
    List<Category> categories,
    List<Game> games,
  ) = SaveData;

  const factory HomeEvent.init(Size size) = HomeInit;
  const factory HomeEvent.resize(Size size) = HomeResize;
}
