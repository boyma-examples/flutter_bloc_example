import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class AppTheme {
  final String id;
  final CustomColorNaming themeData;
  final String Function(BuildContext context) name;

  const AppTheme({
    required this.id,
    required this.themeData,
    required this.name,
  });
}

class CustomColorNaming {
  final Color primary;
  final Color onPrimary;
  final Color primary2;
  final Color surface;
  final Color surfaceLighter;
  final Color surfaceDarker;
  final Color onSurface;
  final Color background;
  final Color background2;
  final Color onBackground;
  final Brightness brightness;

  const CustomColorNaming({
    required this.primary,
    required this.onPrimary,
    required this.primary2,
    required this.surface,
    required this.surfaceLighter,
    required this.surfaceDarker,
    required this.onSurface,
    required this.background,
    required this.background2,
    required this.onBackground,
    required this.brightness,
  });

  CustomColorNaming copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primary2,
    Color? surface,
    Color? surfaceLighter,
    Color? surfaceDarker,
    Color? onSurface,
    Color? background,
    Color? background2,
    Color? onBackground,
    Brightness? brightness,
  }) {
    return CustomColorNaming(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primary2: primary2 ?? this.primary2,
      surface: surface ?? this.surface,
      surfaceLighter: surfaceLighter ?? this.surfaceLighter,
      surfaceDarker: surfaceDarker ?? this.surfaceDarker,
      onSurface: onSurface ?? this.onSurface,
      background: background ?? this.background,
      background2: background2 ?? this.background2,
      onBackground: onBackground ?? this.onBackground,
      brightness: brightness ?? this.brightness,
    );
  }
}

class DarkAppTheme implements AppTheme {
  @override
  String get id => "1";

  @override
  CustomColorNaming get themeData => const CustomColorNaming(
        primary: Color(0xff21254A),
        onPrimary: Colors.white,
        primary2: Color(0xFF84de36),
        surfaceDarker: Color(0xFF2f343b),
        surface: Color(0xFF3E4248),
        surfaceLighter: Color(0xFF4D5258),
        onSurface: Colors.white,
        background: Color(0xFF26282E),
        background2: Color(0xFF373A42),
        onBackground: Colors.white,
        brightness: Brightness.dark,
      );

  @override
  String Function(BuildContext context) get name => (context) {
        return S.of(context).theme_dark;
      };
}

class LightAppTheme implements AppTheme {
  @override
  String get id => "0";

  @override
  String Function(BuildContext context) get name => (context) {
        return S.of(context).theme_light;
      };

  @override
  CustomColorNaming get themeData => const CustomColorNaming(
        primary: Color(0xff21254A),
        onPrimary: Colors.white,
        primary2: Color(0xFF84de36),
        surfaceDarker: Color(0xff2f343b),
        surface: Color(0xFF3E4248),
        surfaceLighter: Color(0xFF4D5258),
        onSurface: Colors.white,
        background: Color(0xFFE6EBEB),
        background2: Color(0xFFF8FDFD),
        onBackground: Color(0xFF3E4248),
        brightness: Brightness.light,
      );
}
