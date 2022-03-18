import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class ErrorFromServer {
  final String? text;

  ErrorFromServer(this.text);
}

String parseError(BuildContext context, dynamic exception) {
  if (exception is DioError && exception.error is ErrorFromServer) {
    return exception.error.text ?? S.of(context).unknown_error;
  }
  return S.of(context).unknown_error;
}
