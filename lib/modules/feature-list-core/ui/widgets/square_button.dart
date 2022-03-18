import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final Widget icon;
  final Function onClick;

  const SquareButton({
    Key? key,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      color: Colors.blue,
      child: InkWell(
        child: icon,
        onTap: () {
          onClick();
        },
      ),
    );
  }
}
