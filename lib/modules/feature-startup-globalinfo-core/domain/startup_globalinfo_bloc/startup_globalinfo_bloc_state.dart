abstract class StartupGlobalInfoBlocState {}

class StartupGlobalInfoBlocStateNormal extends StartupGlobalInfoBlocState {}

class StartupGlobalInfoBlocStateProgress extends StartupGlobalInfoBlocState {}

class StartupGlobalInfoBlocStateError extends StartupGlobalInfoBlocState {
  final dynamic exception;

  StartupGlobalInfoBlocStateError(this.exception);
}
