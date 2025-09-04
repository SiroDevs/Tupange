import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/audio/cubit/audio_player_cubit.dart';
import '../../blocs/home/home_bloc.dart';
import '../../cubits/dashboard/planet_orbital_animation_cubit.dart';
import '../../widgets/background/background.dart';
import '../../widgets/controls/audio_control.dart';
import '../../widgets/info_card/info_card.dart';
import '../../widgets/keyboard_handlers/dashboard_keyboard_handler.dart';
import '../../widgets/stylized_button.dart';
import '../../widgets/stylized_container.dart';
import '../../widgets/stylized_icon.dart';
import '../../../core/constants/app_breakpoints.dart';
import '../../layout/utils/responsive_layout_builder.dart';
import '../../../core/constants/app_constants.dart';
import '../../cubits/dashboard/level_selection_cubit.dart';
import '../../cubits/dashboard/planet_selection_cubit.dart';
import '../../cubits/dashboard/planet_selection_helper_cubit.dart';
import 'widgets/header_widget.dart';
import 'widgets/scroll_buttons.dart';
import 'widgets/sun_widget.dart';

part 'home_view.dart';
part 'home_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PlanetOrbitalAnimationCubit(size),
        ),
        BlocProvider(
          create: (c) => HomeBloc(c.read<PlanetOrbitalAnimationCubit>())
            ..add(DashboardInitialized(size)),
        ),
        BlocProvider(create: (_) => LevelSelectionCubit()),
        BlocProvider(
          create: (c) => PlanetSelectionCubit(
            c.read<LevelSelectionCubit>(),
            context,
          ),
        ),
        BlocProvider(
          create: (c) => PlanetSelectionHelperCubit(
            planetAnimationCubit: c.read<PlanetOrbitalAnimationCubit>(),
          ),
        ),
      ],
      child: const HomeView(),
    );
  }
}
