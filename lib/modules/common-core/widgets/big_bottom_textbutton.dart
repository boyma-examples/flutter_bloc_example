import 'package:flutter/material.dart';

class BigBottomTextButton extends StatelessWidget {
  final String text;
  final double? elevation;
  final Function onClick;
  final bool? enabled;
  final double? borderRadius;

  const BigBottomTextButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.elevation,
    this.borderRadius = 50,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        enabled == true ? onClick() : null;
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 50),
        elevation: elevation ?? 4,
        primary: enabled == true
            ? const Color.fromRGBO(49, 39, 79, 1)
            :  const Color(0xFF9F9F9F),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
      ),
      child: Text(
        text,
      ),
    );
  }
}
