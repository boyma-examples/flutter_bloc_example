abstract class SnackBlocState {}

class SnackBlocStateEmpty extends SnackBlocState {}

class SnackBlocStateMessage extends SnackBlocState {
  final String message;

  SnackBlocStateMessage(this.message);
}

class SnackBlocStateError extends SnackBlocState {
  final dynamic exception;

  SnackBlocStateError(this.exception);
}
