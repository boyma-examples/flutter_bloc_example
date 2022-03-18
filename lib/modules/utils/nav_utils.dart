import 'package:flutter/cupertino.dart';

void navigateBack(BuildContext context) {
  Navigator.of(context).pop();
}

navigateBackWithResult<T>(
  BuildContext context,
  T result,
) {
  Navigator.of(context).pop(result);
}

navTo({
  required BuildContext context,
  required Widget screenWidget,
}) {
  return Navigator.push(
    context,
    MyRoute(
      builder: (_) => screenWidget,
    ),
  );
}

class MyRoute extends CupertinoPageRoute {
  MyRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 700);
}
