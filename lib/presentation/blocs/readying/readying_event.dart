part of 'readying_bloc.dart';

abstract class ReadyingEvent extends Equatable {
  const ReadyingEvent();

  @override
  List<Object?> get props => [];
}

class ReadyingResetEvent extends ReadyingEvent {
  const ReadyingResetEvent();
}

class Countdownstarted extends ReadyingEvent {
  const Countdownstarted();
}

class CountdownTicked extends ReadyingEvent {
  const CountdownTicked();
}

class CountdownStopped extends ReadyingEvent {
  const CountdownStopped();
}

class CountdownReset extends ReadyingEvent {
  const CountdownReset({this.secondsToBegin});

  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];
}
