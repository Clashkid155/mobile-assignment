import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_assessment/common/database.dart';
import 'package:mobile_assessment/model/employee.dart';
import 'package:mobile_assessment/modules/details/state/employees_state.dart';
import 'package:mobile_assessment/modules/widgets/inputs/app_textfield.dart';

import '../../widgets/inputs/form_validators.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/inputs/input_formatter.dart';

class NewEmployeeScreen extends StatefulWidget {
  const NewEmployeeScreen({super.key, required this.employeesState});

  final EmployeesState employeesState;

  @override
  State<NewEmployeeScreen> createState() => _NewEmployeeScreenState();
}

class _NewEmployeeScreenState extends State<NewEmployeeScreen> {
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  // final TextEditingController emailController = TextEditingController();
  final TextEditingController productivityScoreController =
      TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String? selectedLevel;

  String? selectedDesignation;
  Level? parsedLevel;
  bool showSalaryError = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool compareLevel() {
    if (selectedLevel == null || salaryController.text.isEmpty) return false;
    setState(() => parsedLevel = Level.fromString(selectedLevel!));
    if (int.parse(salaryController.text.replaceAll(",", "")) >
        parsedLevel!.pay) {
      setState(() => showSalaryError = true);
      return true;
    }
    setState(() => showSalaryError = false);
    return false;
  }

  String formatNumberWithCommas(String number) {
    return number.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  int generateRandomNumber() {
    final Random random = Random();
    return 30 + random.nextInt(271);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    salaryController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("New Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              CustomTextField(
                controller: firstNameController,
                headerText: "First Name",
                placeholderText: "John",
                validator: Validator.combine([
                  Validator.required,
                  Validator.text,
                ]),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: lastNameController,
                headerText: "Last Name",
                placeholderText: "Doe",
                validator: Validator.combine([
                  Validator.required,
                  Validator.text,
                ]),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: productivityScoreController,
                headerText: "Productivity Score",
                placeholderText: "100",
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  PercentageInputFormatter(),
                ],
                validator: Validator.combine([
                  Validator.required,
                  // Validator.digit,
                ]),
              ),
              const SizedBox(height: 12),
              Text(
                "Level",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              AnchoredDropdown(
                options: Level.labels,
                selectedValue: selectedLevel,
                onChanged: (value) {
                  setState(() => selectedLevel = value);
                  compareLevel();
                },
                hint: "Select Level",
              ),
              Visibility(
                  visible: selectedLevel == null,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "A level must be selected",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  )),
              const SizedBox(height: 12),
              CustomTextField(
                controller: salaryController,
                headerText: "Current Salary",
                placeholderText: "70,000",
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsSeparatorInputFormatter()
                ],
                validator: Validator.combine([
                  Validator.required,
                  // Validator.digit,
                ]),
                onChanged: (_) => compareLevel(),
              ),
              Visibility(
                  visible: showSalaryError,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Salary is higher than base level salary "
                      "${formatNumberWithCommas(parsedLevel?.pay.toString() ?? "0")}",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  )),
              const SizedBox(height: 18),
              Text(
                "Designation",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              AnchoredDropdown(
                options: Designation.labels,
                selectedValue: selectedDesignation,
                onChanged: (value) {
                  setState(() {
                    selectedDesignation = value;
                  });
                },
                hint: "Select Designation",
              ),
              Visibility(
                  visible: selectedDesignation == null,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "A designation must be selected",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  )),
              const SizedBox(height: 24),
              SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            selectedLevel != null &&
                            selectedDesignation != null &&
                            !showSalaryError) {
                          Employee employee = Employee(
                            id: generateRandomNumber(),
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            level: int.parse(selectedLevel!.split(" ")[1]),
                            designation: selectedDesignation!,
                            productivityScore:
                                double.parse(productivityScoreController.text),
                            currentSalary: salaryController.text,
                            employmentStatus: 1,
                          );
                          AppDatabase.insertEmployee(employee).then(
                            (_) {
                              widget.employeesState.fetchEmployees();
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Employee added")));
                              Navigator.pop(context);
                            },
                          );
                        }
                      },
                      child: Text("Add")))
            ],
          ),
        ),
      ),
    );
  }
}
