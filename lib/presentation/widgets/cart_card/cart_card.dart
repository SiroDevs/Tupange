import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/helpers/modal_helpers.dart';
import '../../../core/l10n/l10n.dart';
import '../../../data/models/category.dart';
import '../../../data/models/game.dart';

part 'cart_data.dart';

abstract class CartCard {
  static bool _isVisible = false;
  static Future<void> show({
    required BuildContext context,
    required Category category,
    required List<Game> games,
  }) async {
    if (_isVisible) return;
    _isVisible = true;

    await showAppDialog(
      context: context,
      child: _CartCard(category, games),
    );

    _isVisible = false;
  }
}

class _CartCard extends StatelessWidget {
  final Category category;
  final List<Game> games;

  const _CartCard(this.category, this.games);

  @override
  Widget build(BuildContext context) {
    var categoryItems = GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        itemCount: games.length,
        itemBuilder: (context, index) => _GameItem(games[index]),
    );
    // var categoryGames = SingleChildScrollView(
    //   padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
    //   physics: const BouncingScrollPhysics(),
    //   child: ResponsiveLayoutBuilder(
    //     small: (_, Widget? child) => child!,
    //     medium: (_, Widget? child) => child!,
    //     large: (_, Widget? child) => child!,
    //     child: (_) => Column(
    //       children: games
    //           .map<Widget>((game) => Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 24.0),
    //                 child: _GameItem(game),
    //               ))
    //           .toList(),
    //     ),
    //   ),
    // );
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.80),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 2.0,
          color: Colors.white,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Mpango: ${category.title!.toUpperCase()}',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          categoryItems.expanded(),
        ],
      ),
    );
  }
}

class _GameItem extends StatelessWidget {
  final Game game;
  const _GameItem(this.game);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(game.image!, height: 75, width: 100),
        Expanded(
          flex: 2,
          child: Text(
            game.title!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ],
    );
  }
}
