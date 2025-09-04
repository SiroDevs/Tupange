part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class DashboardLoading extends HomeState {}

class DashboardReady extends HomeState {
  final List<Orbit> orbits;

  const DashboardReady(this.orbits);

  @override
  List<Object> get props => [orbits];
}
