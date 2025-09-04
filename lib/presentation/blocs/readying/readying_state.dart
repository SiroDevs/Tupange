part of 'readying_bloc.dart';

enum GameStatus {
  notStarted,
  loading,
  started,
}

class ReadyingState extends Equatable {
  const ReadyingState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
  });

  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// The status of the current puzzle.
  GameStatus get status => isCountdownRunning && secondsToBegin > 0
      ? GameStatus.loading
      : (secondsToBegin == 0
          ? GameStatus.started
          : GameStatus.notStarted);

  @override
  List<Object> get props => [isCountdownRunning, secondsToBegin];

  ReadyingState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
  }) {
    return ReadyingState(
      isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
      secondsToBegin: secondsToBegin ?? this.secondsToBegin,
    );
  }
}
