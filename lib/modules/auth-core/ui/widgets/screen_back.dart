import 'package:flutter/material.dart';

class ScreenBackground extends StatelessWidget {
  final Widget? child;

  const ScreenBackground({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/1.png"),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          child ?? Container(),
        ],
      ),
    );
  }
}
