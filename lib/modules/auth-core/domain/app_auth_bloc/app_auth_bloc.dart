import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/app-core/app_bloc/app_bloc.dart';
import 'package:flutter_bloc_example/modules/auth-core/domain/models/app_user.dart';

import '../http_client/http_client.dart';
import 'app_auth_bloc_state.dart';

class AppAuthBloc extends Cubit<AppAuthState> {
  final AppBloc appBloc;
  late Dio dioClient;

  AppAuthBloc({
    required this.appBloc,
  }) : super(Uninitialized());

  Future<void> init() async {
    String token = await appBloc.storageRepository.loadToken();
    if (token.isEmpty) {
      dioClient = AuthDioClient(
        baseUrl: appBloc.getDataState().baseUrl,
      ).getClient();
      emit(Unauthenticated());
    } else {
      dioClient = AppDioClient(
        token: token,
        baseUrl: appBloc.getDataState().baseUrl,
        onUnauthenticated: () {
          clearAuth();
          emit(Unauthenticated());
        },
      ).getClient();
      emit(Authenticated(AppUser()));
    }
  }

  Future<void> saveAuth(String token) async {
    await appBloc.storageRepository.setToken(token);
    await init();
  }

  Future<void> clearAuth() async {
    await appBloc.storageRepository.setToken("");
    await init();
  }
}

Dio getDioClient(BuildContext context) {
  return context.read<AppAuthBloc>().dioClient;
}
