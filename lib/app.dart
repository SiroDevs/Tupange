import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/constants/app_constants.dart';
import 'core/audio/bloc/audio_control_bloc.dart';
import 'core/audio/cubit/audio_player_cubit.dart';
import 'presentation/cubits/loading/assetcache_cubit.dart';
import 'presentation/navigator/main_navigator.dart';
import 'presentation/widgets/keyboard_handlers/app_keyboard_handler.dart';

class MyApp extends StatefulWidget {
  final Widget? dashboard;
  const MyApp({super.key, this.dashboard});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final navigatorKey = MainNavigatorState.navigationKey;
  NavigatorState get navigator =>
      MainNavigatorState.navigationKey.currentState!;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AudioControlBloc()),
        BlocProvider(
          create: (context) =>
              AudioPlayerCubit(context.read<AudioControlBloc>()),
        ),
        BlocProvider(create: (_) => AssetcacheCubit()),
      ],
      child: AppKeyboardHandler(
        child: MaterialApp(
          home: widget.dashboard,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          title: 'Tupange',
          theme: ThemeData(fontFamily: AppConstants.kFontFamily),
          initialRoute: MainNavigatorState.initialRoute,
          onGenerateRoute: MainNavigatorState.onGenerateRoute,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
