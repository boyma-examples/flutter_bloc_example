import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/auth-screens/sms_entering/domain/sms_entering_bloc/sms_entering_bloc_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../auth-core/data/auth_repository.dart';
import '../../../../auth-core/data/models/signin_request_dto.dart';
import '../../../../auth-core/data/models/sms_request_dto.dart';
import '../../../../auth-core/domain/app_auth_bloc/app_auth_bloc.dart';
import '../timer_bloc/timer_bloc.dart';

class SmsEnteringBloc extends Cubit<SmsEnteringBlocState> {
  final AuthRepository authRepository;
  final TimerBloc timerBloc;
  final AppAuthBloc appAuthBloc;

  SmsEnteringBloc({
    required this.authRepository,
    required this.timerBloc,
    required this.appAuthBloc,
  }) : super(SmsEnteringBlocStateProgress());

  final _subs = CompositeSubscription();

  @override
  Future<void> close() async {
    _subs.clear();
    timerBloc.close();
    super.close();
  }

  String enteredCode = "";
  String phone = "";

  void requestSms(String number) {
    phone = number;
    emit(SmsEnteringBlocStateProgress());
    authRepository.requestSms(SmsCodeRequestDto(phone: number)).listen(
      (event) {
        timerBloc.startTimer(event.ttl);
        emit(SmsEnteringBlocStateNormal(smsResponse: event));
      },
      onError: (e) {
        emit(SmsEnteringBlocStateError(message: "error"));
      },
    ).addTo(_subs);
  }

  SmsEnteringBlocStateNormal normalState() {
    return (state as SmsEnteringBlocStateNormal);
  }

  void onEnteredCode() {
    var prevState = state;
    emit(SmsEnteringBlocStateProgress());
    authRepository
        .signIn(
      SignInRequestDto(
        phone: phone,
        code: enteredCode,
      ),
    )
        .listen(
      (event) async {
        await appAuthBloc.saveAuth(event.token.toString());
        emit(SmsEnteringBlocStateSuccess());
      },
      onError: (e) {
        emit(prevState);
      },
    ).addTo(_subs);
  }

  void onRepeatSendClick(String number) {
    requestSms(number);
  }

  void onCodeChanged(String newValue) {
    enteredCode = newValue;
  }
}
