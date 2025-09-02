part of 'readying_bloc.dart';

enum PlanetPuzzleStatus {
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
  PlanetPuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? PlanetPuzzleStatus.loading
      : (secondsToBegin == 0
          ? PlanetPuzzleStatus.started
          : PlanetPuzzleStatus.notStarted);

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
