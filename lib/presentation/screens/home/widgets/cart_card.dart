part of '../home_screen.dart';

abstract class CartCard {
  static bool _isVisible = false;
  static Future<void> show({
    required BuildContext ctx,
    required Category category,
    required List<Game> games,
  }) async {
    if (_isVisible) return;
    _isVisible = true;

    await showAppDialog(
      context: ctx,
      child: _CartCard(ctx, category, games),
    );

    _isVisible = false;
  }
}

class _CartCard extends StatelessWidget {
  final BuildContext ctx;
  final Category category;
  final List<Game> games;

  const _CartCard(this.ctx, this.category, this.games);

  @override
  Widget build(BuildContext context) {
    var categoryItems = GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 4,
        childAspectRatio: isMobile ? 2 : 3,
      ),
      itemCount: games.length,
      itemBuilder: (context, index) {
        var game = games[index];
        return _GameItem(
          game: game,
          onSelected: () {
            ctx.read<AudioPlayerCubit>().clickAudio();
            ctx.read<GameSelectionCubit>().onSelected(game);
            Navigator.pop(context);
          },
        );
      },
    );
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
              'Category: ${category.title!.toUpperCase()}',
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
  final VoidCallback? onSelected;
  const _GameItem({required this.game, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Row(
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
      ),
    );
  }
}
