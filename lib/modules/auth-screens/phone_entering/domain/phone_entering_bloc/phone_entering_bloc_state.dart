abstract class PhoneEnteringBlocState {}

class PhoneEnteringBlocStateNormal extends PhoneEnteringBlocState {
  final bool checked;
  final String number;

  PhoneEnteringBlocStateNormal({
    required this.checked,
    required this.number,
  });

  PhoneEnteringBlocStateNormal copyWith({
    bool? checked,
    String? number,
  }) {
    return PhoneEnteringBlocStateNormal(
      checked: checked ?? this.checked,
      number: number ?? this.number,
    );
  }
}

class PhoneEnteringBlocStateProgress extends PhoneEnteringBlocState {}
