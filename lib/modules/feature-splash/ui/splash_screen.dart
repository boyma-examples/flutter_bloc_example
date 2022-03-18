import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff21254A),
      child: const Center(
        child: Icon(
          Icons.stream,
          color: Colors.white,
        ),
      ),
    );
  }
}

///router
Widget navToSplashScreenWidgetGlobal(
  Key key,
) {
  return SplashScreen(key: key);
}
