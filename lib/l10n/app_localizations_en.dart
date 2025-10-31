// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get appTitle => 'Tupange';

  @override
  String get loadingScreenReady => 'Ready when you are, Captain!';

  @override
  String get loadingScreenInitializing => 'Please wait, initializing...';

  @override
  String get start => 'Start';

  @override
  String get selectionHeading => 'Pick a Category, Puzzle ..';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get appShortcuts => 'App Shortcuts';

  @override
  String get appShortcutMusic => 'Mute/Unmute music';

  @override
  String get appShortcutSoundEffect => 'Mute/Unmute sound effect';

  @override
  String get dashboardShortcuts => 'Dashboard Shortcuts';

  @override
  String get dashboardShortcutOrbitalAnimation =>
      'Play/Pause planet orbit animation';

  @override
  String get dashboardShortcutDiffDec => 'Decrease difficulty level';

  @override
  String get dashboardShortcutDiffInc => 'Increase difficulty level';

  @override
  String get dashboardShortcutInfo => 'Show this shortcut dialog';

  @override
  String get dashboardShortcutChooseAPlanet => 'Choose a Planet';

  @override
  String get dashboardShortcutClose => 'Close dialog';

  @override
  String get puzzleShortcuts => 'Puzzle Shortcuts';

  @override
  String get puzzleShortcutControl => 'Start / Auto Solve / Stop';

  @override
  String get puzzleShortcutRestart => 'Restart puzzle';

  @override
  String get puzzleShortcutHintVisibility => 'Toggle number hint visibility';

  @override
  String get whitespaceUp => 'Move whitespace up';

  @override
  String get whitespaceDown => 'Move whitespace down';

  @override
  String get whitespaceLeft => 'Move whitespace left';

  @override
  String get whitespaceRight => 'Move whitespace right';

  @override
  String get backToHome => 'Go back to Home';

  @override
  String get home => 'Home';

  @override
  String get stop => 'Stop';

  @override
  String get restart => 'Restart';

  @override
  String get autoSolve => 'Auto Solve';

  @override
  String get getReady => 'Get Ready';

  @override
  String get pleaseWait => 'Please Wait';

  @override
  String get go => 'Go!';

  @override
  String get notStarted => 'Not Started';

  @override
  String puzzleStats(String timeText, int numberOfMoves) {
    return '$timeText | $numberOfMoves Moves';
  }

  @override
  String sharableText(String planetName) {
    return 'I just assembled $planetName, it\'s a fun challenge, join the #FlutterPuzzleHack! Check it out here ↓';
  }

  @override
  String get congrats => 'Congrats!';

  @override
  String get congratsSubTitle => 'You\'re an intergalactic champ!';

  @override
  String successMessage(String planetName, String extraText) {
    return 'You have successfully put together our $planetName $extraText';
  }

  @override
  String get scoreBoard => 'Score Board';

  @override
  String totalMoves(int totalMoves) {
    return '$totalMoves moves';
  }

  @override
  String get usedAutosolve => 'Used Auto solve';

  @override
  String get noAutosolve => 'No Auto solve';

  @override
  String get share => 'Share!';

  @override
  String get optimizedLabel => 'Optimized Puzzle';

  @override
  String get optimizedDescription =>
      'You are running an optimized version of the puzzle, to avoid performance drop';

  @override
  String get levelSelectionLabel =>
      'Choose puzzle level from easy, medium or hard';

  @override
  String puzzleDurationLabelText(String hours, String minutes, String seconds) {
    return '$hours hours $minutes minutes $seconds seconds';
  }

  @override
  String get visibilityButtonSemanticLabel =>
      'Show/hide puzzle help - tile numbers';
}
