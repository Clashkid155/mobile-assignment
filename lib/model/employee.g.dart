// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: (json['id'] as num).toInt(),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      designation: json['designation'] as String,
      productivityScore: (json['productivity_score'] as num).toDouble(),
      currentSalary: json['current_salary'] as String,
      level: (json['level'] as num).toInt(),
      employmentStatus: (json['employment_status'] as num).toInt(),
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'designation': instance.designation,
      'productivity_score': instance.productivityScore,
      'current_salary': instance.currentSalary,
      'level': instance.level,
      'employment_status': instance.employmentStatus,
    };
