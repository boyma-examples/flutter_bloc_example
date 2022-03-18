import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/app-core/app_storage_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../theme_manager/theme_manager.dart';
import '../theme_manager/themes.dart';
import 'app_bloc_state.dart';

class AppBloc extends Cubit<AppState> {
  final AppStorageRepository storageRepository;

  AppBloc({
    required this.storageRepository,
  }) : super(AppEmptyState());

  final _subs = CompositeSubscription();

  @override
  Future<void> close() async {
    _subs.clear();
    super.close();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 0));
    await initStorage();

    var localeCode = await _initLocale();
    var themeManager = await _initThemeManager();
    String baseUrl = await _getAppBaseUrl();

    emit(
      AppStateData(
        galleryThemeManager: themeManager,
        localeCode: localeCode,
        baseUrl: baseUrl,
      ),
    );
  }

  Future<void> initStorage() async {
    var isFirstRun = await storageRepository.loadFirstRun();
    if (isFirstRun ?? true) {
      await storageRepository.deleteAll();
      await storageRepository.setFirstRun(false);
    }
  }

  Future<String> _initLocale() async {
    return await storageRepository.loadLocale();
  }

  Future<ThemeManager> _initThemeManager() async {
    return ThemeManager(await storageRepository.loadThemeId());
  }

  void setLanguage(String localeCode) {
    storageRepository.setLocaleCode(localeCode);
    emit(getDataState().copyWith(localeCode: localeCode));
  }

  void setThemeId(String themeId) {
    storageRepository.setThemeId(themeId);
    emit(getDataState().copyWith(galleryThemeManager: ThemeManager(themeId)));
  }

  AppTheme getCurrentAppTheme() {
    return getDataState().galleryThemeManager.appTheme;
  }

  AppStateData getDataState() {
    return (state as AppStateData);
  }

  Future<String> _getAppBaseUrl() async {
    return "";
  }
}
