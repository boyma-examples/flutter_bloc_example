import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'startup_globalinfo_bloc_state.dart';

class StartupGlobalInfoBloc extends Cubit<StartupGlobalInfoBlocState> {
  StartupGlobalInfoBloc() : super(StartupGlobalInfoBlocStateProgress());

  final _subs = CompositeSubscription();

  @override
  Future<void> close() async {
    cancelConnections();
    super.close();
  }

  cancelConnections() {
    _subs.clear();
  }

  void loadInfo() {
    emit(StartupGlobalInfoBlocStateProgress());
    Stream.fromFuture(
      Future.delayed(
        const Duration(seconds: 5),
      ),
    ).listen(
      (event) {
        emit(StartupGlobalInfoBlocStateNormal());
      },
      onError: (e) {},
    ).addTo(_subs);
  }
}
