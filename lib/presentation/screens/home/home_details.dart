part of 'home_screen.dart';

class HomeSmall extends StatelessWidget {
  final Widget child;

  const HomeSmall({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class HomeMedium extends StatelessWidget {
  final Widget child;

  const HomeMedium({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class HomeDetails extends StatelessWidget {
  final List<Category> categories;
  final List<Game> games;

  const HomeDetails({super.key, required this.categories, required this.games});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return OrientationBuilder(
      builder: (context, orientation) {
        return SizedBox(
          height: height * 0.6,
          child: LayoutBuilder(
            builder: (ctx, dimens) {
              final height2 = dimens.maxHeight;
              double aspectRatio;
              if (orientation == Orientation.portrait) {
                aspectRatio = width / height2;
              } else {
                aspectRatio = height2 / width;
              }
              return CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: aspectRatio,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  autoPlay: true,
                ),
                items: categories.map((category) {
                  return Builder(
                    builder: (BuildContext ctx) {
                      return MenuCarousel(
                        category: category,
                        height: height2 * 1.5,
                        onPressed: () {
                          context.read<AudioPlayerCubit>().clickAudio();
                          context
                              .read<CategorySelectionCubit>()
                              .onSelected(category);

                          var selectedGames = games
                              .where((game) => game.category == category.id)
                              .toList();

                          if (selectedGames.isNotEmpty) {
                            CartCard.show(
                              ctx: context,
                              category: category,
                              games: selectedGames,
                            );
                          }
                        },
                      );
                    },
                  );
                }).toList(),
              );
            },
          ),
        );
      },
    );
  }
}
