import 'package:flutter_bloc_example/modules/auth-core/domain/models/app_user.dart';

abstract class AppAuthState {}

class Uninitialized extends AppAuthState {}

class AuthInProgress extends AppAuthState {}

class Authenticated extends AppAuthState {
  final AppUser user;

  Authenticated(this.user);
}

class Unauthenticated extends AppAuthState {}
