import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/audio/cubit/audio_player_cubit.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/modal_helpers.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/utils.dart';
import '../../../data/models/category.dart';
import '../../../data/models/game.dart';
import '../../../data/models/puzzle.dart';
import '../../blocs/home/home_bloc.dart';
import '../../cubits/category/category_selection_cubit.dart';
import '../../cubits/game/game_selection_cubit.dart';
import '../../widgets/controls/audio_control.dart';
import '../../widgets/progress/custom_snackbar.dart';
import '../../widgets/progress/general_progress.dart';
import '../../layout/utils/responsive_layout_builder.dart';
import '../../cubits/level/level_selection_cubit.dart';
import '../../widgets/stylized_button.dart';
import '../../widgets/stylized_container.dart';
import '../../widgets/stylized_icon.dart';
import '../../widgets/stylized_text.dart';

part 'home_view.dart';
part 'home_details.dart';
part 'widgets/cart_card.dart';
part 'widgets/header_widget.dart';
part 'widgets/menu_carousel.dart';
part 'widgets/scroll_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => HomeBloc()..add(FetchData()),
        ),
        BlocProvider(create: (_) => LevelSelectionCubit()),
      ],
      child: const HomeView(),
    );
  }
}
