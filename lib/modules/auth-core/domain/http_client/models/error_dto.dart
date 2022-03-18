part 'error_dto.g.dart';

class ErrorDto {
  final String? text;

  ErrorDto({this.text});

  factory ErrorDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDtoToJson(this);
}
