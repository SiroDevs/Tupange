import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/l10n/l10n.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/audio/cubit/audio_player_cubit.dart';
import '../../../core/utils/utils.dart';
import '../../../core/constants/app_assets.dart';
import '../../layout/utils/responsive_layout_builder.dart';
import '../home/home_screen.dart';
import '../../widgets/background/background.dart';
import '../../widgets/stylized_button.dart';
import '../../widgets/stylized_container.dart';
import '../../widgets/stylized_text.dart';
import 'widgets/loading.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  void _move(BuildContext context) async {
    /// we can play the theme music only upon the first interaction
    /// due to chrome policy: https://goo.gl/xX8pDD
    context.read<AudioPlayerCubit>().playThemeMusic();

    final page = await Utils.buildPageAsync(const HomeScreen());

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: AppConstants.kMS800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AudioPlayerCubit, AudioPlayerState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bool isReady = state is AudioPlayerReady;

        return Background(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                // body
                ResponsiveLayoutBuilder(
                  small: (_, __) => _LoadingScreenSmall(
                    isInitialized: true,
                    isReady: isReady,
                    onStartPressed: () => _move(context),
                  ),
                  medium: (_, Widget? child) => child!,
                  large: (_, Widget? child) => child!,
                  child: (_) => _LoadingScreenLarge(
                    isInitialized: true,
                    isReady: isReady,
                    onStartPressed: () => _move(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LoadingScreenLarge extends StatelessWidget {
  final bool isReady;
  final bool isInitialized;
  final VoidCallback onStartPressed;

  const _LoadingScreenLarge({
    required this.isReady,
    required this.isInitialized,
    required this.onStartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Image.asset(AppAssets.planetsImage),
        ),
        Expanded(
          child: _MainBody(
            isLarge: true,
            isInitialized: isInitialized,
            isReady: isReady,
            onPressed: onStartPressed,
          ),
        ),
      ],
    );
  }
}

class _LoadingScreenSmall extends StatelessWidget {
  final bool isReady;
  final bool isInitialized;
  final VoidCallback onStartPressed;

  const _LoadingScreenSmall({
    required this.isReady,
    required this.isInitialized,
    required this.onStartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // show asset
          Expanded(
            flex: 5,
            child: Image.asset(AppAssets.planetsImage),
          ),

          // show rest body
          Expanded(
            flex: 7,
            child: _MainBody(
              isInitialized: isInitialized,
              isReady: isReady,
              onPressed: onStartPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _MainBody extends StatelessWidget {
  final bool isReady;
  final bool isInitialized;
  final bool isLarge;
  final VoidCallback onPressed;

  const _MainBody({
    this.isLarge = false,
    required this.isInitialized,
    required this.isReady,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // app name
        Column(
          children: [
            StylizedText(
              text: context.l10n.appTitle,
              fontSize: isLarge ? 68.0 : 48.0,
              textColor: Utils.darkenColor(Colors.blue),
              strokeColor: Colors.white,
            ),
            const Gap(4.0),
          ],
        ),

        Column(
          children: [
            // loading animation
            AnimatedSwitcher(
              duration: AppConstants.kMS300,
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: !isInitialized
                  ? Text(
                      context.l10n.loadingScreenInitializing,
                      key: const Key('initializing'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.90),
                        fontSize: isLarge ? 28.0 : 22.0,
                        letterSpacing: 1.4,
                      ),
                    )
                  : Text(
                      context.l10n.loadingScreenReady,
                      key: const Key('ready'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.90),
                        fontSize: isLarge ? 28.0 : 22.0,
                        letterSpacing: 1.4,
                      ),
                    ),
            ),

            const Gap(28.0),

            // loading animation
            AnimatedOpacity(
              duration: AppConstants.kMS300,
              opacity: isReady ? 1.0 : 0.0,
              child: Loading(
                key: ValueKey(isReady),
                tileSize: isLarge ? 60.0 : 40.0,
              ),
            ),
          ],
        ),

        // start button
        StylizedButton(
          onPressed: () {
            if (isReady && isInitialized) {
              onPressed();
            }
          },
          child: StylizedContainer(
            color: isReady && isInitialized ? Colors.greenAccent : Colors.grey,
            child: StylizedText(
              text: context.l10n.start,
              fontSize: isLarge ? 32.0 : 24.0,
            ),
          ),
        ),
      ],
    );
  }
}
