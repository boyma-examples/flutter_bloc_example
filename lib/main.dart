import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/utils/nav_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';
import 'modules/app-core/app_bloc/app_bloc.dart';
import 'modules/app-core/app_bloc/app_bloc_state.dart';
import 'modules/app-core/app_storage_repository.dart';
import 'modules/app-core/progress_bloc/progress_bloc.dart';
import 'modules/app-core/progress_bloc/progress_bloc_state.dart';
import 'modules/app-core/snack_bloc/snack_bloc.dart';
import 'modules/app-core/snack_bloc/snack_bloc_state.dart';
import 'modules/auth-core/domain/app_auth_bloc/app_auth_bloc.dart';
import 'modules/auth-core/domain/app_auth_bloc/app_auth_bloc_state.dart';
import 'modules/auth-core/domain/http_client/http_defaulterror_parser.dart';
import 'modules/auth-screens/phone_entering/ui/phone_entering_screen.dart';
import 'modules/common-core/dialogs/progress_dialog.dart';
import 'modules/feature-list/list/ui/feature_list_screen.dart';
import 'modules/feature-splash/ui/splash_screen.dart';
import 'modules/feature-startup-globalinfo-core/domain/startup_globalinfo_bloc/startup_globalinfo_bloc.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appStorageRepository = AppStorageRepositoryImpl(
    prefs: await SharedPreferences.getInstance(),
    secureStorage: const FlutterSecureStorage(),
  );
  runApp(
    MyHomePage(
      appStorageRepository: appStorageRepository,
    ),
  );
}

class MyHomePage extends StatefulWidget {
  final AppStorageRepository appStorageRepository;

  const MyHomePage({
    Key? key,
    required this.appStorageRepository,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _splashKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (_) => ProgressBloc()),
        BlocProvider(
          lazy: false,
          create: (_) => AppBloc(
            storageRepository: widget.appStorageRepository,
          )..init(),
        ),
        BlocProvider(lazy: false, create: (_) => SnackBloc()),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (BuildContext context, appState) {
          if (appState is AppStateData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                S.delegate
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: Locale(appState.localeCode),
              theme: appState.galleryThemeManager.currentThemeData(context),
              home: Scaffold(
                resizeToAvoidBottomInset: false,
                body: MultiBlocListener(
                  listeners: [
                    BlocListener<ProgressBloc, ProgressBlocState>(
                      listener: (context, state) {
                        if (state.isShow) {
                          showProgressDialog(context);
                        } else {
                          navigateBack(context);
                        }
                      },
                    ),
                    BlocListener<SnackBloc, SnackBlocState>(
                      listener: (BuildContext context, state) {
                        if (state is SnackBlocStateMessage) {
                          showAppSnack(context, state.message);
                        } else if (state is SnackBlocStateError) {
                          showAppSnack(
                            context,
                            parseError(context, state.exception),
                          );
                        }
                      },
                    )
                  ],
                  child: BlocProvider(
                    lazy: false,
                    create: (_) => AppAuthBloc(
                      appBloc: context.read<AppBloc>(),
                    )..init(),
                    child: BlocBuilder<AppAuthBloc, AppAuthState>(
                      builder: (context, state) {
                        if (state is Unauthenticated) {
                          return _navToPhoneEnteringScreen(context);
                        } else if (state is Authenticated) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (_) => StartupGlobalInfoBloc(),
                              ),
                            ],
                            child: _navToFeatureListScreenWidget(context)
                          );
                        }
                        return _navToSplashScreenWidget();
                      },
                    ),
                  ),
                ),
              ),
            );
          }
          return MaterialApp(home: _navToSplashScreenWidget());
        },
      ),
    );
  }

  void showAppSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  /// -----------------------------------
  ///   NAVIGATE METHODS
  /// -----------------------------------
  Future<void> showProgressDialog(BuildContext context) async {
    var result = await showProgressCircle(context);
    if (result == null) context.read<ProgressBloc>().cancel();
  }

  Widget _navToSplashScreenWidget() {
    return navToSplashScreenWidgetGlobal(
      _splashKey,
    );
  }

  Widget _navToPhoneEnteringScreen(BuildContext context) {
    return navToPhoneEnteringScreenWidget(context);
  }

  Widget _navToFeatureListScreenWidget(BuildContext context) {
    return navToFeatureListScreenWidget(context);
  }
}
