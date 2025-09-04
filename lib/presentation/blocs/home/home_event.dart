part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class DashboardInitialized extends HomeEvent {
  final Size size;

  const DashboardInitialized(this.size);

  @override
  List<Object> get props => [size];
}

class DashboardResized extends HomeEvent {
  final Size size;

  const DashboardResized(this.size);

  @override
  List<Object> get props => [size];
}
