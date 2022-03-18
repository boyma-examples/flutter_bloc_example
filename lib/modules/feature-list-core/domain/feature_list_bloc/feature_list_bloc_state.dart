import 'package:flutter_bloc_example/modules/feature-list-core/data/models/item_dto.dart';

abstract class FeatureListBlocState {}

class FeatureListBlocStateError extends FeatureListBlocState {}

class FeatureListBlocStateProgress extends FeatureListBlocState {}

class FeatureListBlocStateData extends FeatureListBlocState {
  final List<SomeItemDto> list;
  FeatureListBlocStateData(this.list);
}
