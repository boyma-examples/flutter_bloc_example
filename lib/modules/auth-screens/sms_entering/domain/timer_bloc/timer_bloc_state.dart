abstract class TimerBlocState {}

class TimerBlocStateWaitForStart extends TimerBlocState {}

class TimerBlocStateStopped extends TimerBlocState {}

class TimerBlocStateStarted extends TimerBlocState {
  final int timeElapsed;

  TimerBlocStateStarted({
    required this.timeElapsed,
  });

  TimerBlocStateStarted copyWith({
    int? timeElapsed,
  }) {
    return TimerBlocStateStarted(
      timeElapsed: timeElapsed ?? this.timeElapsed,
    );
  }
}
