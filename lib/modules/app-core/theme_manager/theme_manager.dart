import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_example/generated/l10n.dart';
import 'package:flutter_bloc_example/modules/app-core/theme_manager/themes.dart';

class ThemeManager {
  late final AppTheme appTheme;

  ThemeManager(
    String themeId,
  ) {
    var theme = getThemes().singleWhere((element) => element.id == themeId);
    appTheme = theme;
  }

  ThemeData currentThemeData(BuildContext context) {
    var colorNaming = appTheme.themeData;
    return ThemeData(
      colorScheme: getColorScheme(appTheme.themeData),
      brightness: colorNaming.brightness,
      primaryColor: colorNaming.primary,
      primaryColorDark: colorNaming.primary,
      backgroundColor: colorNaming.background,
      appBarTheme: AppBarTheme(
        color: colorNaming.background,
        systemOverlayStyle:
            getSystemUiOverlayStyle(context, brightness: Brightness.dark),
        titleTextStyle: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: colorNaming.primary,
        ),
        toolbarTextStyle: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: colorNaming.primary,
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: colorNaming.primary),
      ),
      canvasColor: colorNaming.background,
      scaffoldBackgroundColor: colorNaming.background,
      highlightColor: Colors.transparent,
      focusColor: colorNaming.primary,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          Colors.black.withOpacity(0.80),
          Colors.white,
        ),
        contentTextStyle: TextStyle(
          fontSize: 14.0,
          color: colorNaming.onSurface,
        ),
      ),
    );
  }

  ColorScheme getColorScheme(CustomColorNaming themeData) {
    return ColorScheme(
      primary: themeData.primary,
      secondary: themeData.primary,
      onSecondary: const Color(0xFF322942),
      background: themeData.background,
      surface: themeData.surface,
      //0xFF747679
      onBackground: themeData.onBackground,
      error: Colors.black,
      onError: Colors.black,
      onPrimary: themeData.onPrimary,
      onSurface: themeData.onSurface,
      brightness: themeData.brightness,
    );
  }

  List<AppTheme> getThemes() {
    return [
      DarkAppTheme(),
      LightAppTheme(),
      AppTheme(
        id: '3',
        name: (BuildContext context) {
          return S.of(context).theme_dark + "2";
        },
        themeData: DarkAppTheme().themeData.copyWith(primary: Colors.purple),
      ),
      /*const AppTheme().let(
        (it) => DarkAppTheme(
            id: "2", themeData: it.themeData.copyWith(primary: Colors.purple)),
      )*/
    ];
  }
}

SystemUiOverlayStyle getSystemUiOverlayStyle(BuildContext context,
    {Brightness? brightness}) {
  var darkColor = const Color(0xFF26282E);
  var lightColor = const Color(0xFFE6EBEB);
  return SystemUiOverlayStyle(
    systemNavigationBarColor:
        (brightness ?? Theme.of(context).brightness) == Brightness.dark
            ? darkColor
            : lightColor,
    // navigation bar color
    statusBarColor:
        (brightness ?? Theme.of(context).brightness) == Brightness.dark
            ? darkColor
            : lightColor,
    // status bar color
    statusBarBrightness: brightness ?? Theme.of(context).brightness,
    //status bar brigtness
    statusBarIconBrightness:
        inverseBrightness(brightness ?? Theme.of(context).brightness),
    //status barIcon Brightness
    systemNavigationBarDividerColor:
        (brightness ?? Theme.of(context).brightness) == Brightness.dark
            ? darkColor
            : lightColor,
    //Navigation bar divider color
    systemNavigationBarIconBrightness:
        brightness ?? Theme.of(context).brightness, //navigation bar icon
  );
}

Brightness inverseBrightness(Brightness brightness) {
  if (brightness == Brightness.dark) {
    return Brightness.light;
  } else {
    return Brightness.dark;
  }
}
