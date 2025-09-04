part of 'home_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  Size get size => MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
    context.read<AudioPlayerCubit>().playThemeMusic();
    WidgetsBinding.instance.addObserver(this);
    context.read<PlanetOrbitalAnimationCubit>().setTickerProvider(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final s = size;
    if (s.width > AppBreakpoints.medium) {
      context.read<HomeBloc>().add(DashboardResized(s));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select((HomeBloc bloc) => bloc.state);

    if (state is DashboardLoading) {
      return const SizedBox.shrink();
    }

    return DashboardKeyboardHandler(
      orbits: (state as DashboardReady).orbits,
      child: Background(
        child: SizedBox.fromSize(
          size: size,
          child: Stack(
            children: [
              // solar system
              ResponsiveLayoutBuilder(
                small: (_, Widget? child) => HomeDetailsSmall(child: child!),
                medium: (_, Widget? child) =>
                    HomeDetailsMedium(child: child!),
                large: (_, Widget? child) => child!,
                child: (_) => HomeDetailsLarge(state: state),
              ),

              // header
              const HeaderWidget(),

              // music control
              ResponsiveLayoutBuilder(
                small: (_, __) => const SizedBox.shrink(),
                medium: (_, __) => const SizedBox.shrink(),
                large: (_, __) => const Align(
                  alignment: AppConstants.kFOTopRight,
                  child: AudioControl(),
                ),
              ),

              // planet animation pause/play button
              const Align(
                alignment: AppConstants.kFOBottomRight,
                child: _PlanetAnimationToggleButton(),
              ),

              // info button
              ResponsiveLayoutBuilder(
                small: (_, __) => const Align(
                  alignment: AppConstants.kFOBottomLeft,
                  child: _InfoButton(),
                ),
                medium: (_, __) => const Align(
                  alignment: AppConstants.kFOTopLeft,
                  child: _InfoButton(),
                ),
                large: (_, __) => const Align(
                  alignment: AppConstants.kFOTopLeft,
                  child: _InfoButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoButton extends StatelessWidget {
  const _InfoButton();

  @override
  Widget build(BuildContext context) {
    return StylizedButton(
      onPressed: () {
        InfoCard.show(context: context);
      },
      child: const StylizedContainer(
        padding: EdgeInsets.all(12.0),
        color: Colors.greenAccent,
        child: StylizedIcon(
          icon: FontAwesomeIcons.info,
          size: 15.0,
          offset: 1.0,
          strokeWidth: 5.0,
        ),
      ),
    );
  }
}

class _PlanetAnimationToggleButton extends StatelessWidget {
  const _PlanetAnimationToggleButton();

  @override
  Widget build(BuildContext context) {
    final state =
        context.select((PlanetSelectionHelperCubit cubit) => cubit.state);

    final bool isPaused = state.isPaused;

    return StylizedButton(
      onPressed: () {
        context.read<PlanetSelectionHelperCubit>().onPlanetMovementToggle();
      },
      child: StylizedContainer(
        color: isPaused ? Colors.grey : Colors.blueAccent,
        padding: const EdgeInsets.all(12.0),
        child: StylizedIcon(
          icon: isPaused ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
          size: 15.0,
          offset: 1.0,
          strokeWidth: 5.0,
        ),
      ),
    );
  }
}
