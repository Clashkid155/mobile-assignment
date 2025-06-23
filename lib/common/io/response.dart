import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_assessment/model/employee.dart';
import 'package:mobile_assessment/model/errors_response.dart';

part 'response.g.dart';

@JsonSerializable(
    // explicitToJson: true,
    )
class StatusResponse {
  final String message;
  final List<ErrorsResponse>? errors;

  @DataResponseConverter()
  final DataResponse data;

  const StatusResponse({
    required this.message,
    required this.errors,
    required this.data,
  });

  factory StatusResponse.fromJson(Map<String, dynamic> json) =>
      _$StatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StatusResponseToJson(this);
}

sealed class DataResponse {}

class ErrorDataResponse extends DataResponse {
  final Map<String, dynamic> errorItem;

  ErrorDataResponse(this.errorItem);

  ErrorDataResponse.empty() : errorItem = {};
}

class SuccessDataResponse extends DataResponse {
  final List<Employee> employees;

  SuccessDataResponse(this.employees);
}

class DataResponseConverter implements JsonConverter<DataResponse, dynamic> {
  const DataResponseConverter();

  @override
  DataResponse fromJson(json) {
    if (json is List) {
      return SuccessDataResponse(json
          .map(
            (e) => Employee.fromJson(e),
          )
          .toList());
    } else if (json is Map) {
      return ErrorDataResponse(json.cast<String, dynamic>());
    }
    throw FormatException("Expected either List or Map");
  }

  @override
  toJson(DataResponse object) {
    return object is SuccessDataResponse
        ? object.employees
        : (object as ErrorDataResponse).errorItem;
  }
}
