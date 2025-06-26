import 'package:mobile_assessment/model/employee.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import 'io/data.dart';
import 'io/response.dart';

class AppDatabase {
  AppDatabase._();

  static late final Future<Database> _database;
  static final String _tableName = 'employee';

  static void init() async {
    _database = openDatabase(
      join(await getDatabasesPath(), 'employee.db'),
      // When the database is first created, create a table to store employees.
      onCreate: (db, version) async {
        db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, '
          'first_name TEXT, last_name TEXT, designation TEXT, '
          'level INTEGER, current_salary INTEGER, employment_status INTEGER,'
          'productivity_score REAL)',
        );
        final batch = db.batch();
        for (var element in (StatusResponse.fromJson(Api.successResponse).data
                as SuccessDataResponse)
            .employees) {
          batch.insert(
            _tableName,
            element.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await batch.commit();
        return;
      },

      version: 1,
    );
  }

  // Define a function that inserts employee into the database
  static Future<void> insertEmployee(Employee employee) async {
    // Get a reference to the database.
    final db = await _database;

    // Insert the Employee into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same employee is inserted twice.
    //
    // In this case, replace any previous data.

    await db.insert(
      _tableName,
      employee.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the employees from the employee table.
  static Future<List<Employee>> getEmployees() async {
    final db = await _database;

    final List<Map<String, Object?>> employeeMaps = await db.query(_tableName);
    return employeeMaps.map((e) => Employee.fromJson(e)).toList();
  }
}
