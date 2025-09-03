import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_assets.dart';
import '../../../core/utils/constants/app_constants.dart';
import '../../../data/models/position.dart';
import '../../../data/models/bubble.dart';

class Background extends StatefulWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> with WidgetsBindingObserver {
  final List<Bubble> bubbles = [];
  final _random = math.Random();

  Size? _lastSize;
  List<Position>? _bubblePositions;
  late List<double> _bubbleSizes;
  late List<double> _bubbleRotations;

  List<Position> _generatePositions(int n, {required Size currentSize}) {
    if (_lastSize == null || _bubblePositions == null) {
      // as no last size is available, generate new positions
      _bubblePositions = List<Position>.generate(
        n,
        (i) => Position(
          x: _random.nextInt(currentSize.width.toInt()),
          y: _random.nextInt(currentSize.height.toInt()),
        ),
      );
    } else {
      _bubblePositions = List<Position>.generate(
        n,
        (i) => Position(
          x: _bubblePositions![i].x * currentSize.width ~/ _lastSize!.width,
          y: _bubblePositions![i].y * currentSize.height ~/ _lastSize!.height,
        ),
      );
    }

    return _bubblePositions!;
  }

  List<Bubble> _makeBubbles(int n) {
    final size = MediaQuery.of(context).size;

    // get positions for all n bubbles
    final positions = _generatePositions(n, currentSize: size);

    _lastSize = size;

    return List.generate(
      n,
      (i) => Bubble(
        value: i,
        pos: positions[i],
        size: _bubbleSizes[i],
        rotation: _bubbleRotations[i],
      ),
    );
  }

  Timer? _debounce;

  void _buildBubbles({bool isFirstTime = false}) {
    if (_debounce?.isActive == true) _debounce?.cancel();
    _debounce = Timer(AppConstants.kMS150, () {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!isFirstTime) bubbles.clear();
        setState(() => bubbles.addAll(_makeBubbles(AppConstants.kNoBubbles)));
      });
    });
  }

  void _initBubbleVariables() {
    _bubbleSizes = List.generate(
      AppConstants.kNoBubbles,
      (i) => math.max(_random.nextDouble(), AppConstants.kBubblePercentage) * AppConstants.kBubbleSize,
    );

    _bubbleRotations = List.generate(
      AppConstants.kNoBubbles,
      (i) => _random.nextDouble() * math.pi,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initBubbleVariables();
    _buildBubbles(isFirstTime: true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _buildBubbles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.nairobiImg),
              fit: BoxFit.cover,
            ),
          ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...bubbles.map<Widget>((s) => s.widget),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
