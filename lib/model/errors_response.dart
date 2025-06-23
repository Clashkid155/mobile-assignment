import 'package:json_annotation/json_annotation.dart';

part 'errors_response.g.dart';

// @JsonSerializable(fieldRename: FieldRename.snake)
@JsonSerializable()
class ErrorsResponse {
  final String errorCode;
  final String message;

  ErrorsResponse({
    required this.errorCode,
    required this.message,
  });

  /* Employee copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? designation,
    double? productivityScore,
    String? currentSalary,
    int? level,
    int? employmentStatus,
  }) =>
      Employee(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        designation: designation ?? this.designation,
        productivityScore: productivityScore ?? this.productivityScore,
        currentSalary: currentSalary ?? this.currentSalary,
        level: level ?? this.level,
        employmentStatus: employmentStatus ?? this.employmentStatus,
      );*/

  // String get avatarUrl => 'https://api.dicebear.com/7.x/miniavs/png?seed=$id';

  factory ErrorsResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorsResponseToJson(this);
}
