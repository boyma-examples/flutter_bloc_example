class ProgressBlocState {
  final bool isShow;

  ProgressBlocState({
    required this.isShow,
  });

  ProgressBlocState copyWith({
    bool? isShow,
  }) {
    return ProgressBlocState(
      isShow: isShow ?? this.isShow,
    );
  }
}
