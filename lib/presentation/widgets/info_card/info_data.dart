import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../l10n/app_localizations.dart';
import 'info_pair.dart';

class InfoData {
  final String title;
  final List<InfoPair> infoPairs;

  const InfoData({
    required this.title,
    required this.infoPairs,
  });
}

abstract class AppShortcutData {
  static List<InfoData> data(BuildContext context) => [
        InfoData(
          title: AppLocalizations.of(context)!.appShortcuts,
          infoPairs: [
            InfoPair(
              titleText: 'M',
              description: AppLocalizations.of(context)!.appShortcutMusic,
            ),
            InfoPair(
              titleText: 'S',
              description: AppLocalizations.of(context)!.appShortcutSoundEffect,
            ),
          ],
        ),
        InfoData(
          title: AppLocalizations.of(context)!.dashboardShortcuts,
          infoPairs: [
            InfoPair(
              showIcon: true,
              titleIcon: Icons.space_bar_rounded,
              description: AppLocalizations.of(context)!.dashboardShortcutOrbitalAnimation,
            ),
            InfoPair(
              showIcon: true,
              titleIcon: FontAwesomeIcons.arrowLeft,
              description: AppLocalizations.of(context)!.dashboardShortcutDiffDec,
            ),
            InfoPair(
              showIcon: true,
              titleIcon: FontAwesomeIcons.arrowRight,
              description: AppLocalizations.of(context)!.dashboardShortcutDiffInc,
            ),
            InfoPair(
              titleText: 'i',
              description: AppLocalizations.of(context)!.dashboardShortcutInfo,
            ),
            InfoPair(
              titleText: '1 - 9',
              description: AppLocalizations.of(context)!.dashboardShortcutChooseAPlanet,
            ),
            InfoPair(
              titleText: 'ESC',
              description: AppLocalizations.of(context)!.dashboardShortcutClose,
            ),
          ],
        ),
        InfoData(
          title: AppLocalizations.of(context)!.puzzleShortcuts,
          infoPairs: [
            InfoPair(
              showIcon: true,
              titleIcon: Icons.space_bar_rounded,
              description: AppLocalizations.of(context)!.puzzleShortcutControl,
            ),
            InfoPair(
              titleText: 'R',
              description: AppLocalizations.of(context)!.puzzleShortcutRestart,
            ),
            InfoPair(
              titleText: 'V',
              description: AppLocalizations.of(context)!.puzzleShortcutHintVisibility,
            ),
            InfoPair(
              showIcon: true,
              titleIcon: FontAwesomeIcons.arrowUp,
              description: AppLocalizations.of(context)!.whitespaceUp,
            ),
            InfoPair(
              showIcon: true,
              titleIcon: FontAwesomeIcons.arrowDown,
              description: AppLocalizations.of(context)!.whitespaceDown,
            ),
            InfoPair(
              showIcon: true,
              titleIcon: FontAwesomeIcons.arrowLeft,
              description: AppLocalizations.of(context)!.whitespaceLeft,
            ),
            InfoPair(
              showIcon: true,
              titleIcon: FontAwesomeIcons.arrowRight,
              description: AppLocalizations.of(context)!.whitespaceRight,
            ),
            InfoPair(
              titleText: 'ESC',
              description: AppLocalizations.of(context)!.backToHome,
            ),
          ],
        ),
      ];
}
