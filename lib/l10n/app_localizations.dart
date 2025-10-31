import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// The title of the app
  ///
  /// In en, this message translates to:
  /// **'Tupange'**
  String get appTitle;

  /// Ready text shown in Loading screen, after important assets are cached
  ///
  /// In en, this message translates to:
  /// **'Ready when you are, Captain!'**
  String get loadingScreenReady;

  /// When caching, show initializing text
  ///
  /// In en, this message translates to:
  /// **'Please wait, initializing...'**
  String get loadingScreenInitializing;

  /// Start Button text
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// Instruction to start the game
  ///
  /// In en, this message translates to:
  /// **'Pick a Category, Puzzle ..'**
  String get selectionHeading;

  /// Level - easy, for the game
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// Level - medium, for the game
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// Level - hard, for the game
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// Heading for app shortcuts info
  ///
  /// In en, this message translates to:
  /// **'App Shortcuts'**
  String get appShortcuts;

  /// Music shortcut
  ///
  /// In en, this message translates to:
  /// **'Mute/Unmute music'**
  String get appShortcutMusic;

  /// Sound effect shortcut
  ///
  /// In en, this message translates to:
  /// **'Mute/Unmute sound effect'**
  String get appShortcutSoundEffect;

  /// Heading for dashboard shortcuts info
  ///
  /// In en, this message translates to:
  /// **'Dashboard Shortcuts'**
  String get dashboardShortcuts;

  /// Instruction for planet orbital animation
  ///
  /// In en, this message translates to:
  /// **'Play/Pause planet orbit animation'**
  String get dashboardShortcutOrbitalAnimation;

  /// Decrease difficulty level
  ///
  /// In en, this message translates to:
  /// **'Decrease difficulty level'**
  String get dashboardShortcutDiffDec;

  /// Increase difficulty level
  ///
  /// In en, this message translates to:
  /// **'Increase difficulty level'**
  String get dashboardShortcutDiffInc;

  /// Choose a planet to begin the puzzle
  ///
  /// In en, this message translates to:
  /// **'Show this shortcut dialog'**
  String get dashboardShortcutInfo;

  /// No description provided for @dashboardShortcutChooseAPlanet.
  ///
  /// In en, this message translates to:
  /// **'Choose a Planet'**
  String get dashboardShortcutChooseAPlanet;

  /// Close dialog shortcut info
  ///
  /// In en, this message translates to:
  /// **'Close dialog'**
  String get dashboardShortcutClose;

  /// Heading for puzzle shortcuts info
  ///
  /// In en, this message translates to:
  /// **'Puzzle Shortcuts'**
  String get puzzleShortcuts;

  /// To control the puzzle, i.e. start/stop or to start auto solver
  ///
  /// In en, this message translates to:
  /// **'Start / Auto Solve / Stop'**
  String get puzzleShortcutControl;

  /// Restart puzzle
  ///
  /// In en, this message translates to:
  /// **'Restart puzzle'**
  String get puzzleShortcutRestart;

  /// Toggling hint visibility
  ///
  /// In en, this message translates to:
  /// **'Toggle number hint visibility'**
  String get puzzleShortcutHintVisibility;

  /// Move whitespace up
  ///
  /// In en, this message translates to:
  /// **'Move whitespace up'**
  String get whitespaceUp;

  /// Move whitespace down
  ///
  /// In en, this message translates to:
  /// **'Move whitespace down'**
  String get whitespaceDown;

  /// Move whitespace left
  ///
  /// In en, this message translates to:
  /// **'Move whitespace left'**
  String get whitespaceLeft;

  /// Move whitespace right
  ///
  /// In en, this message translates to:
  /// **'Move whitespace right'**
  String get whitespaceRight;

  /// Quit puzzle screen and go back to dashboard
  ///
  /// In en, this message translates to:
  /// **'Go back to Home'**
  String get backToHome;

  /// Home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Stop puzzle
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// Restart puzzle
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// Auto solve puzzle
  ///
  /// In en, this message translates to:
  /// **'Auto Solve'**
  String get autoSolve;

  /// Get Ready puzzle
  ///
  /// In en, this message translates to:
  /// **'Get Ready'**
  String get getReady;

  /// Please wait puzzle
  ///
  /// In en, this message translates to:
  /// **'Please Wait'**
  String get pleaseWait;

  /// Go - stats
  ///
  /// In en, this message translates to:
  /// **'Go!'**
  String get go;

  /// Not Started - puzzle stats
  ///
  /// In en, this message translates to:
  /// **'Not Started'**
  String get notStarted;

  /// Puzzle Stats
  ///
  /// In en, this message translates to:
  /// **'{timeText} | {numberOfMoves} Moves'**
  String puzzleStats(String timeText, int numberOfMoves);

  /// Text that can be shared on social media
  ///
  /// In en, this message translates to:
  /// **'I just assembled {planetName}, it\'s a fun challenge, join the #FlutterPuzzleHack! Check it out here ↓'**
  String sharableText(String planetName);

  /// Puzzle completion congrats text
  ///
  /// In en, this message translates to:
  /// **'Congrats!'**
  String get congrats;

  /// Puzzle completion sub title
  ///
  /// In en, this message translates to:
  /// **'You\'re an intergalactic champ!'**
  String get congratsSubTitle;

  /// Puzzle completion success message
  ///
  /// In en, this message translates to:
  /// **'You have successfully put together our {planetName} {extraText}'**
  String successMessage(String planetName, String extraText);

  /// Score board title
  ///
  /// In en, this message translates to:
  /// **'Score Board'**
  String get scoreBoard;

  /// total moves
  ///
  /// In en, this message translates to:
  /// **'{totalMoves} moves'**
  String totalMoves(int totalMoves);

  /// If user had used auto solve during gameplay
  ///
  /// In en, this message translates to:
  /// **'Used Auto solve'**
  String get usedAutosolve;

  /// If user had NOT used auto solve during gameplay
  ///
  /// In en, this message translates to:
  /// **'No Auto solve'**
  String get noAutosolve;

  /// Share text
  ///
  /// In en, this message translates to:
  /// **'Share!'**
  String get share;

  /// The label to show, if a puzzle is running an optimized version
  ///
  /// In en, this message translates to:
  /// **'Optimized Puzzle'**
  String get optimizedLabel;

  /// The description of why the optimized label is shown
  ///
  /// In en, this message translates to:
  /// **'You are running an optimized version of the puzzle, to avoid performance drop'**
  String get optimizedDescription;

  /// Semantic label for level selection widget
  ///
  /// In en, this message translates to:
  /// **'Choose puzzle level from easy, medium or hard'**
  String get levelSelectionLabel;

  /// Semantic label for the puzzle timer
  ///
  /// In en, this message translates to:
  /// **'{hours} hours {minutes} minutes {seconds} seconds'**
  String puzzleDurationLabelText(String hours, String minutes, String seconds);

  /// Semantic label for the visibility helper button
  ///
  /// In en, this message translates to:
  /// **'Show/hide puzzle help - tile numbers'**
  String get visibilityButtonSemanticLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
