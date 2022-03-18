class SignInRequestDto {
  SignInRequestDto({
    this.phone = "",
    this.code = "",
  });

  SignInRequestDto.fromJson(dynamic json) {
    phone = json['phone'];
    code = json['code'];
  }

  late String phone;
  late String code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    return map;
  }
}
