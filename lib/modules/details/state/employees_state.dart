import 'package:flutter/cupertino.dart';
import 'package:mobile_assessment/common/io/data.dart';
import 'package:mobile_assessment/common/io/response.dart';
import 'package:mobile_assessment/model/employee.dart';
import 'package:mobile_assessment/model/errors_response.dart';

class EmployeesState with ChangeNotifier {
  bool _isLoading = false;
  List<Employee> _employees = [];
  List<Employee> _filteredEmployees = [];
  StatusResponse? _response;
  String filterName = "";
  bool isFilterActive = false;

  // Getters
  bool get isLoading => _isLoading;

  List<Employee> get employees => _filteredEmployees;

  StatusResponse? get response => _response;
  List<bool> checkedDesignation =
      List<bool>.filled(Designation.values.length, false);

  // List<int> level = [0, 1, 2, 3, 4, 5];
  List<bool> checkedLevel = List<bool>.filled(6, false); //[];

  List getValue(List checked, {bool isDesignation = false}) {
    final List des = [];
    for (int i = 0; i < checked.length; i++) {
      if (checked[i]) {
        des.add(isDesignation ? Designation.values[i].label : i);
      }
    }
    return des;
  }

  void clearFilter() {
    filterName = "";
    checkedDesignation = List<bool>.filled(Designation.values.length, false);
    checkedLevel = List<bool>.filled(6, false);
    isFilterActive = false;
    _filteredEmployees = List.from(_employees);
    notifyListeners();
  }

  bool filterActive() {
    if (filterName.isEmpty &&
        checkedDesignation.every(
          (element) => element == false,
        ) &&
        checkedLevel.every(
          (element) => element == false,
        )) {
      return true;
    }
    return false;
  }

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

  void searchByNameOrDesignation(String query) {
    /* filterName = query;
    if (query.isEmpty) {
      // If search query is empty, show all employees or apply existing filters
      filterEmployees();
      return;
    }*/
    _filteredEmployees = _employees.where((employee) {
      final nameMatch =
          employee.fullName.toLowerCase().contains(query.toLowerCase());
      final designationMatch =
          employee.designation.toLowerCase().contains(query.toLowerCase());
      return nameMatch || designationMatch;
    }).toList();
    // isFilterActive = true;
    notifyListeners();
  }

  void filterEmployees() {
    if (filterActive()) return;
    _filteredEmployees = List.from(_employees);

    if (filterName.isNotEmpty) {
      _filteredEmployees = _filteredEmployees
          .where((employee) => (employee.fullName)
              .toLowerCase()
              .contains(filterName.toLowerCase()))
          .toList();
    }

    final levels = getValue(checkedLevel).cast<int>();
    if (levels.isNotEmpty) {
      _filteredEmployees = _filteredEmployees
          .where((employee) => levels.contains(employee.level))
          .toList();
    }
    final designations =
        getValue(checkedDesignation, isDesignation: true).cast<String>();
    if (designations.isNotEmpty) {
      final lowerCaseDesignations =
          designations.map((d) => d.toLowerCase()).toList();
      _filteredEmployees = _filteredEmployees.where((employee) {
        if (employee.designation.isEmpty) {
          return false;
        }
        // Check if any of the provided designations are contained in the employee's designation
        // This allows for partial matches as well as full matches.
        // For an exact match of one of the designations, you would use:
        // return lowerCaseDesignations.contains(employee.designation!.toLowerCase());
        return lowerCaseDesignations.any((d) =>
            (employee.designation).toLowerCase().contains(d.toLowerCase()));
      }).toList();
    }
    isFilterActive = true;
    notifyListeners();
  }
}
