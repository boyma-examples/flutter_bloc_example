import '../theme_manager/theme_manager.dart';

abstract class AppState {}

class AppEmptyState extends AppState {}

class AppStateData extends AppState {
  final ThemeManager galleryThemeManager;
  final String localeCode;
  final String baseUrl;

  AppStateData({
    required this.galleryThemeManager,
    required this.localeCode,
    required this.baseUrl,
  });

  AppStateData copyWith({
    ThemeManager? galleryThemeManager,
    String? localeCode,
    String? baseUrl,
  }) {
    return AppStateData(
      galleryThemeManager: galleryThemeManager ?? this.galleryThemeManager,
      localeCode: localeCode ?? this.localeCode,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }
}
