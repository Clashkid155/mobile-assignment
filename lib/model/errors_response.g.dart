// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'errors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorsResponse _$ErrorsResponseFromJson(Map<String, dynamic> json) =>
    ErrorsResponse(
      errorCode: json['errorCode'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ErrorsResponseToJson(ErrorsResponse instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
