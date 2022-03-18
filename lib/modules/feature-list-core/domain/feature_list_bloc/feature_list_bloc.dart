import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/feature_list_repository.dart';
import '../../data/models/item_dto.dart';
import 'feature_list_bloc_state.dart';

class FeatureListBloc extends Cubit<FeatureListBlocState> {
  final FeatureListRepository featureListRepository;

  FeatureListBloc({
    required this.featureListRepository,
  }) : super(FeatureListBlocStateProgress());

  final _subs = CompositeSubscription();

  void loadData() {
    emit(FeatureListBlocStateProgress());
    featureListRepository.loadData().listen(
      (data) {
        emit(FeatureListBlocStateData(data));
      },
      onError: (e) {
        emit(FeatureListBlocStateError());
      },
    ).addTo(_subs);
  }

  void onAddItemClick() {
    featureListRepository.generateItem().listen(
      (data) {
        emit(
          FeatureListBlocStateData(
            (state as FeatureListBlocStateData).list..add(data),
          ),
        );
      },
      onError: (e) {
        emit(FeatureListBlocStateError());
      },
    ).addTo(_subs);
  }

  void onDeleteItemClick(SomeItemDto e) {
    emit(
      FeatureListBlocStateData(
        (state as FeatureListBlocStateData).list..remove(e),
      ),
    );
  }
}
