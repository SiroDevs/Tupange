part of 'home_screen.dart';

class HomeDetailsSmall extends StatelessWidget {
  final Widget child;

  const HomeDetailsSmall({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollableSolarSystem(solarSystem: child);
  }
}

class HomeDetailsMedium extends StatelessWidget {
  final Widget child;

  const HomeDetailsMedium({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollableSolarSystem(solarSystem: child);
  }
}

class ScrollableSolarSystem extends StatefulWidget {
  final Widget solarSystem;

  const ScrollableSolarSystem({
    super.key,
    required this.solarSystem,
  });

  @override
  State<ScrollableSolarSystem> createState() => _ScrollableSolarSystemState();
}

class _ScrollableSolarSystemState extends State<ScrollableSolarSystem> {
  final _controller = ScrollController();

  double get width => MediaQuery.of(context).size.width;

  double _scrollOffset = 0.0;

  void _scrollListener() {
    _scrollOffset = _controller.offset;
  }

  void _moveToOffset() {
    _controller.animateTo(
      _scrollOffset,
      duration: AppConstants.kMS350,
      curve: Curves.easeInOut,
    );
  }

  void _onMoveNext() {
    _scrollOffset =
        math.min(AppBreakpoints.medium - width, _scrollOffset + width);
    _moveToOffset();
  }

  void _onMovePrev() {
    _scrollOffset = math.max(0.0, _scrollOffset - width);
    _moveToOffset();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // solar system
        SingleChildScrollView(
          controller: _controller,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: AppBreakpoints.medium,
            child: widget.solarSystem,
          ),
        ),

        // control buttons
        Align(
          alignment: AppConstants.kFOBottomCenter,
          child: ScrollButtons(onPrevious: _onMovePrev, onNext: _onMoveNext),
        ),
      ],
    );
  }
}

class HomeDetailsLarge extends StatelessWidget {
  final DashboardReady state;

  const HomeDetailsLarge({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // sun
        const SunWidget(
          key: Key('Sun'),
        ),

        // orbits
        ...state.orbits.map<Widget>((orbit) => orbit.widget),

        // planets
        ...(state).orbits.map<Widget>((orbit) => orbit.planet.widget),
      ],
    );
  }
}
