import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Employee {
  final int id;
  final String firstName;
  final String lastName;
  final String designation;
  final double productivityScore;
  final String currentSalary;
  final int level;
  final int employmentStatus;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.productivityScore,
    required this.currentSalary,
    required this.level,
    required this.employmentStatus,
  });

  Employee copyWith({
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
      );

  EmploymentStatus get promotionStatus => switch (productivityScore) {
        >= 80 && <= 100 => EmploymentStatus.promoted,
        >= 50 && <= 79 => EmploymentStatus.notPromoted,
        >= 40 && <= 49 => EmploymentStatus.demoted,
        // _ when productivityScore <= 39 => EmploymentStatus.promoted,
        _ => EmploymentStatus.terminated
      };

  String get newSalary => switch (level + 1) {
        0 => '70,000',
        1 => '100,000',
        2 => '120,000',
        3 => '180,000',
        4 => '200,000',
        5 => '250,000',
        _ => ""
      };

  String get fullName => '$firstName $lastName';

  String get avatarInitials => '${firstName[0]}${lastName[0]}';

  // String get avatarUrl => 'https://api.dicebear.com/7.x/miniavs/png?seed=$id';

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

enum Designation {
  customerRelations(label: 'Customer Relations'),
  legal(label: 'Legal'),
  tech(label: 'Tech'),
  humanResources(label: 'Human Resources');

  const Designation({
    required this.label,
  });

  final String label;

  static List<String> get labels => values.map((e) => e.label).toList();
}

enum Level {
  level0(label: 'Level 0', pay: 70_000),
  level1(label: 'Level 1', pay: 100_000),
  level2(label: 'Level 2', pay: 120_000),
  level3(label: 'Level 3', pay: 180_000),
  level4(label: 'Level 4', pay: 200_000),
  level5(label: 'Level 5', pay: 250_000);

  final String label;
  final int pay;

  const Level({required this.label, required this.pay});

  static List<String> get labels => values.map((e) => e.label).toList();

  static Level fromString(String label) => switch (label) {
        'Level 0' => Level.level0,
        'Level 1' => Level.level1,
        'Level 2' => Level.level2,
        'Level 3' => Level.level3,
        'Level 4' => Level.level4,
        'Level 5' => Level.level5,
        _ => throw ArgumentError('Invalid level: $label'),
      };
}

enum EmploymentStatus {
  promoted(color: Colors.green, label: 'Promoted'),
  notPromoted(color: Colors.blue, label: 'Not Promoted'),
  demoted(color: Colors.orange, label: 'Demoted'),
  terminated(color: Colors.red, label: 'Terminated');

  const EmploymentStatus({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

/*  static EmploymentStatus fromInt(int status) {
    return switch (status) {
      0 => EmploymentStatus.promoted,
      1 => EmploymentStatus.notPromoted,
      2 => EmploymentStatus.demoted,
      3 => EmploymentStatus.terminated,
      _ => throw ArgumentError('Invalid employment status: $status'),
    };
  }*/
}
