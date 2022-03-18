import 'package:flutter_bloc_example/modules/auth-core/domain/models/signin_response.dart';

import '../domain/models/sms_response.dart';
import 'models/signin_request_dto.dart';
import 'models/sms_request_dto.dart';

abstract class AuthRepository {
  Stream<SmsCodeResponse> requestSms(SmsCodeRequestDto smsRequestDto);

  Stream<SignInResponse> signIn(SignInRequestDto signInRequestDto);
}

class AuthRepositoryMockImpl extends AuthRepository {
  final requestDelay = 5;

  AuthRepositoryMockImpl();

  @override
  Stream<SmsCodeResponse> requestSms(SmsCodeRequestDto smsRequestDto) {
    return Stream.fromFuture(
      Future.delayed(Duration(seconds: requestDelay)).then(
        (value) => Future.value(
          SmsCodeResponse(ttl: 15),
        ),
      ),
    );
  }

  @override
  Stream<SignInResponse> signIn(SignInRequestDto signInRequestDto) {
    return Stream.fromFuture(
      Future.delayed(Duration(seconds: requestDelay)).then(
        (value) => Future.value(
          SignInResponse(token: "token"),
        ),
      ),
    );
  }
}
