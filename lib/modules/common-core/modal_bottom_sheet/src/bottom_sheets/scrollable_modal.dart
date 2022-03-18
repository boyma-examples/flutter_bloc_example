import 'package:flutter/material.dart';

import 'cupertino_bottom_sheet.dart';

class ScrollableModal extends StatelessWidget {
  final Widget? child;

  const ScrollableModal({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: const Duration(milliseconds: 350),
      child: Material(
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: child ?? Container(),
          ),
        ),
      ),
    );
  }
}

///router
showScrollableCupertinoModalBottomSheet({
  required BuildContext context,
  required Widget child,
}) {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (bcontext) {
      return ScrollableModal(
        child: child,
      );
    },
  );
}
