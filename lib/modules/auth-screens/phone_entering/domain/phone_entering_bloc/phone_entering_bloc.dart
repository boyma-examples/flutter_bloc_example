import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'phone_entering_bloc_state.dart';

class PhoneEnteringBloc extends Cubit<PhoneEnteringBlocState> {
  PhoneEnteringBloc()
      : super(PhoneEnteringBlocStateNormal(checked: false, number: ""));

  final _subs = CompositeSubscription();

  @override
  Future<void> close() async {
    _subs.clear();
    super.close();
  }

  PhoneEnteringBlocStateNormal normalState() {
    return (state as PhoneEnteringBlocStateNormal);
  }

  void onTelChanged(String newValue) {
    emit(normalState().copyWith(number: newValue));
  }
}
