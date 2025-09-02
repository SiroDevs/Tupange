import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/ticker.dart';

part 'readying_event.dart';
part 'readying_state.dart';

class ReadyingBloc extends Bloc<ReadyingEvent, ReadyingState> {
  final int secondsToBegin;

  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  ReadyingBloc({
    required this.secondsToBegin,
    required Ticker ticker,
  })  : _ticker = ticker,
        super(ReadyingState(secondsToBegin: secondsToBegin)) {
    on<CountdownStarted>(_onCountdownStarted);
    on<CountdownTicked>(_onCountdownTicked);
    on<CountdownStopped>(_onCountdownStopped);
    on<CountdownReset>(_onCountdownReset);
    on<ResetEvent>(_onResetEvent);
  }

  void _onResetEvent(
    ResetEvent event,
    Emitter<ReadyingState> emit,
  ) {
    emit(state.copyWith(
      secondsToBegin: secondsToBegin,
      isCountdownRunning: false,
    ));
  }

  void _startTicker() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick().listen((_) => add(const CountdownTicked()));
  }

  void _onCountdownStarted(
    CountdownStarted event,
    Emitter<ReadyingState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownTicked(
    CountdownTicked event,
    Emitter<ReadyingState> emit,
  ) {
    if (state.secondsToBegin == 0) {
      _tickerSubscription?.pause();
      emit(state.copyWith(isCountdownRunning: false));
    } else {
      emit(state.copyWith(secondsToBegin: state.secondsToBegin - 1));
    }
  }

  void _onCountdownStopped(
    CountdownStopped event,
    Emitter<ReadyingState> emit,
  ) {
    _tickerSubscription?.pause();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownReset(
    CountdownReset event,
    Emitter<ReadyingState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: event.secondsToBegin,
      ),
    );
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
