class SmsCodeRequestDto {
  SmsCodeRequestDto({
    this.phone = "",
  });

  SmsCodeRequestDto.fromJson(dynamic json) {
    phone = json['phone'];
  }

  late String phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    return map;
  }
}
