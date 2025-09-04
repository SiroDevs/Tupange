import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/level/level_selection_cubit.dart';
import '../info_card/info_card.dart';

class DashboardKeyboardHandler extends StatefulWidget {
  final Widget child;

  const DashboardKeyboardHandler({
    super.key,
    required this.child,
  });

  @override
  _DashboardKeyboardHandlerState createState() =>
      _DashboardKeyboardHandlerState();
}

class _DashboardKeyboardHandlerState extends State<DashboardKeyboardHandler> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  /// For the dashboard, the following keyboard events are important
  /// [Space] key -> play/pause planet orbital animation
  /// [LeftArrow] key -> decrease difficulty level
  /// [RightArrow] key -> increase difficulty level
  /// [i] key -> show info card
  /// [1 - 9] num key -> choose a planet (Mercury - Pluto)
  /// [esc] key -> close dialog
  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final physicalKey = event.data.physicalKey;

      if (physicalKey == PhysicalKeyboardKey.space) {
      } else if (physicalKey == PhysicalKeyboardKey.arrowLeft) {
        context.read<LevelSelectionCubit>().onLevelDecrease();
      } else if (physicalKey == PhysicalKeyboardKey.arrowRight) {
        context.read<LevelSelectionCubit>().onLevelIncrease();
      } else if (physicalKey == PhysicalKeyboardKey.keyI) {
        InfoCard.show(context: context);
      } else if (physicalKey == PhysicalKeyboardKey.escape) {
        final navigatorState = Navigator.of(context);
        if (navigatorState.canPop()) navigatorState.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      child: Builder(builder: (context) {
        if (!_focusNode.hasFocus) {
          FocusScope.of(context).requestFocus(_focusNode);
        }
        return widget.child;
      }),
    );
  }
}
