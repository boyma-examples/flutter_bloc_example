import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/app-core/snack_bloc/snack_bloc_state.dart';

class SnackBloc extends Cubit<SnackBlocState> {
  SnackBloc() : super(SnackBlocStateEmpty());

  void showMessage(String s) {
    emit(SnackBlocStateMessage(s));
  }

  void showError(dynamic s) {
    emit(SnackBlocStateError(s));
  }
}

