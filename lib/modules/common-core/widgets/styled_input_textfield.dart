import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String initialValue;
  final String hintText;
  final Function(String text) onTextChanged;
  final bool isPasswordField;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? masks;

  const CustomTextField({
    Key? key,
    this.initialValue = "",
    required this.hintText,
    required this.onTextChanged,
    this.isPasswordField = false,
    this.keyboardType,
    this.masks,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _textFieldFocus = FocusNode();
  late TextEditingController _controller;

  Color fillColor = const Color(0xffc0c0c0);
  Color unfillColor = Colors.transparent;
  Color unfocusedNoTextBorderColor = const Color(0xffb6b6b6);
  Color unfocusedWithTextBorderColor = const Color(0xffbebebe);
  Color focusedBorderColor = const Color(0xff727272);

  Color currentBorderColor = Colors.white;
  Color currentFillColor = Colors.white;

  bool obscureText = false;

  @override
  void initState() {
    _controller = TextEditingController.fromValue(
      TextEditingValue(text: widget.initialValue),
    );
    obscureText = widget.isPasswordField;
    currentBorderColor = unfocusedNoTextBorderColor;
    if (widget.initialValue.isEmpty) {
      currentFillColor = fillColor;
    } else {
      currentFillColor = unfillColor;
    }
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          currentBorderColor = focusedBorderColor;
        });
      } else {
        setState(() {
          if (_controller.text.isEmpty) {
            currentBorderColor = unfocusedNoTextBorderColor;
          } else {
            currentBorderColor = unfocusedWithTextBorderColor;
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var borderRad = const BorderRadius.all(Radius.circular(10));
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 8,
        top: 1,
      ),
      decoration: BoxDecoration(
          //border: Border.all(color: color1),
          borderRadius: borderRad,
          color: currentFillColor,
          border: Border.all(color: currentBorderColor)),
      child: TextFormField(
        focusNode: _textFieldFocus,
        obscureText: obscureText,
        cursorColor: focusedBorderColor,
        controller: _controller,
        onChanged: (s) {
          if (s.isEmpty) {
            setState(() {
              currentFillColor = fillColor;
            });
          } else if (s.isNotEmpty) {
            setState(() {
              currentFillColor = unfillColor;
            });
          }
          widget.onTextChanged(s);
        },
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
        inputFormatters: widget.masks ?? [],
        keyboardType: widget.keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle: const TextStyle(color: Colors.black),
          filled: false,
          border: InputBorder.none,
          suffixIcon: widget.isPasswordField
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 10,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: Icon(
                        obscureText
                            ? Icons.remove_red_eye_rounded
                            : Icons.remove_red_eye_outlined,
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
