import 'error_dto.dart';

part 'error_response_dto.g.dart';

class ErrorResponseDto {
  final ErrorDto? error;

  ErrorResponseDto({this.error});

  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseDtoToJson(this);
}
