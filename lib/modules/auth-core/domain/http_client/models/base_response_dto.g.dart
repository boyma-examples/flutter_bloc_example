// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseDto<T> _$BaseResponseDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponseDto<T>(
      success: json['success'] as bool?,
      data: fromJsonT(json['dialogs']),
    );

Map<String, dynamic> _$BaseResponseDtoToJson<T>(
  BaseResponseDto<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'dialogs': toJsonT(instance.data),
    };
