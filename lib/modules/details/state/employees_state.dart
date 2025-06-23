import 'package:flutter/cupertino.dart';
import 'package:mobile_assessment/common/io/data.dart';
import 'package:mobile_assessment/common/io/response.dart';
import 'package:mobile_assessment/model/employee.dart';
import 'package:mobile_assessment/model/errors_response.dart';

class EmployeesState with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Employee> _employees = [];
  List<Employee> _filteredEmployees = [];
  StatusResponse? _response;

  StatusResponse? get response => _response;

  Future<void> fetchEmployees() async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await Api.getEmployees();
      _employees = (_response!.data as SuccessDataResponse).employees;
      _filteredEmployees = List.from(_employees); // Initialize filtered list
    } catch (e, s) {
      _response = StatusResponse(
        message: "",
        errors: [
          ErrorsResponse(errorCode: "400", message: "Network error: $e")
        ],
        data: ErrorDataResponse.empty(),
      );
      debugPrintStack(stackTrace: s);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterEmployees({String? name, int? level, String? designation}) {
    _filteredEmployees = List.from(_employees); // Start with all employees

    if (name != null && name.isNotEmpty) {
      _filteredEmployees = _filteredEmployees
          .where((employee) =>
              employee.fullName?.toLowerCase().contains(name.toLowerCase()) ??
              false)
          .toList();
    }

    if (level != null) {
      _filteredEmployees = _filteredEmployees
          .where((employee) => employee.level == level ?? false)
          .toList();
    }

    if (designation != null && designation.isNotEmpty) {
      _filteredEmployees = _filteredEmployees
          .where((employee) =>
              employee.designation
                  ?.toLowerCase()
                  .contains(designation.toLowerCase()) ??
              false)
          .toList();
    }
    notifyListeners();
  }
}
