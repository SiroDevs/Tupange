part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class Timerstarted extends TimerEvent {
  const Timerstarted();
}

class TimerTicked extends TimerEvent {
  const TimerTicked(this.secondsElapsed);

  final int secondsElapsed;

  @override
  List<Object> get props => [secondsElapsed];
}

class TimerStopped extends TimerEvent {
  const TimerStopped();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}
