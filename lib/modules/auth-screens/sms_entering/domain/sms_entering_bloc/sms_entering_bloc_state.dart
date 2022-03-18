import '../../../../auth-core/domain/models/sms_response.dart';

abstract class SmsEnteringBlocState {}

class SmsEnteringBlocStateNormal extends SmsEnteringBlocState {
  final SmsCodeResponse smsResponse;

  SmsEnteringBlocStateNormal({required this.smsResponse});
}

class SmsEnteringBlocStateSuccess extends SmsEnteringBlocState {}

class SmsEnteringBlocStateProgress extends SmsEnteringBlocState {}

class SmsEnteringBlocStateError extends SmsEnteringBlocState {
  final String message;

  SmsEnteringBlocStateError({required this.message});
}
