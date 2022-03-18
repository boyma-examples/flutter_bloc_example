import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/app-core/progress_bloc/progress_bloc_state.dart';

class ProgressBloc extends Cubit<ProgressBlocState> {
  ProgressBloc() : super(ProgressBlocState(isShow: false));

  var cancelNotifier = StreamController<bool>.broadcast();

  void runProgress(bool bool) {
    emit(ProgressBlocState(isShow: bool));
  }

  @override
  Future<void> close() async {
    cancelNotifier.close();
    super.close();
  }

  void cancel() {
    cancelNotifier.sink.add(true);
  }
}
