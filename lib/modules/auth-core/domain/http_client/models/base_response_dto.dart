part 'base_response_dto.g.dart';

class BaseResponseDto<T> {
  final bool? success;
  final T data;

  BaseResponseDto({
    this.success,
    required this.data,
  });

  factory BaseResponseDto.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseDtoFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseDtoToJson(this, toJsonT);
}
