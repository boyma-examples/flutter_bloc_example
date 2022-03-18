import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/auth-screens/sms_entering/domain/timer_bloc/timer_bloc_state.dart';
import 'package:rxdart/rxdart.dart';

class TimerBloc extends Cubit<TimerBlocState> {
  TimerBloc() : super(TimerBlocStateWaitForStart());

  final _subs = CompositeSubscription();

  @override
  Future<void> close() async {
    _subs.clear();
    super.close();
  }

  void startTimer(int maxSeconds) {
    emit(TimerBlocStateStarted(timeElapsed: maxSeconds));
    Stream.periodic(
      const Duration(seconds: 1),
      (e) {
        if (e >= maxSeconds) {
          _subs.clear();
          emit(TimerBlocStateStopped());
        } else {
          emit(TimerBlocStateStarted(timeElapsed: maxSeconds - e));
        }
      },
    )
        .listen(
          (event) {},
          onError: (e) {},
        )
        .addTo(_subs);
  }

  TimerBlocStateStarted startedState() {
    return (state as TimerBlocStateStarted);
  }

}
