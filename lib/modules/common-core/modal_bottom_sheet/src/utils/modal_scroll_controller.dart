import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ModalScrollController extends InheritedWidget {
  /// Creates a widget that associates a [ScrollController] with a subtree.
  ModalScrollController({
    Key? key,
    required this.controller,
    required Widget child,
  })  : super(
          key: key,
          child: PrimaryScrollController(
            controller: controller,
            child: child,
          ),
        );

  /// The [ScrollController] associated with the subtree.
  ///
  /// See also:
  ///
  ///  * [ScrollView.controller], which discusses the purpose of specifying a
  ///    scroll controller.
  final ScrollController controller;

  /// Returns the [ScrollController] most closely associated with the given
  /// context.
  ///
  /// Returns null if there is no [ScrollController] associated with the given
  /// context.
  static ScrollController? of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ModalScrollController>();
    return result?.controller;
  }

  @override
  bool updateShouldNotify(ModalScrollController oldWidget) =>
      controller != oldWidget.controller;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ScrollController>(
        'controller', controller,
        ifNull: 'no controller', showName: false));
  }
}
