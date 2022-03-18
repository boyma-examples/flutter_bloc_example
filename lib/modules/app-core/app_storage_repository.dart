import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppStorageRepository {
  Future<bool?> loadFirstRun();

  Future<void> setFirstRun(bool value);

  Future<String> loadToken();

  Future<void> setToken(String value);

  Future<String> loadLocale();

  Future<void> setLocaleCode(String value);

  Future<String> loadThemeId();

  Future<void> setThemeId(String themeId);

  Future<void> deleteAll();
}

class AppStorageRepositoryImpl extends AppStorageRepository {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences prefs;

  AppStorageRepositoryImpl({
    required this.secureStorage,
    required this.prefs,
  });

  final _firstRun = "firstRun";
  final _locale = "locale";
  final _theme = "theme";
  final _refreshToken = "token";

  @override
  Future<void> setFirstRun(bool value) {
    return prefs.setBool(_firstRun, value);
  }

  @override
  Future<bool?> loadFirstRun() async {
    return Future.value(prefs.getBool(_firstRun));
  }

  @override
  Future<void> setLocaleCode(String value) {
    return secureStorage.write(key: _locale, value: value);
  }

  @override
  Future<String> loadLocale() async {
    return await secureStorage.read(key: _locale) ?? "ru";
  }

  @override
  Future<void> setThemeId(String themeId) {
    return secureStorage.write(key: _theme, value: themeId);
  }

  @override
  Future<String> loadThemeId() async {
    return await secureStorage.read(key: _theme) ?? "0";
  }

  @override
  Future<void> setToken(String value) {
    return secureStorage.write(key: _refreshToken, value: value);
  }

  @override
  Future<String> loadToken() async {
    return await secureStorage.read(key: _refreshToken) ?? "";
  }

  @override
  Future<void> deleteAll() async {
    await prefs.clear();
    await secureStorage.deleteAll();
  }
}
