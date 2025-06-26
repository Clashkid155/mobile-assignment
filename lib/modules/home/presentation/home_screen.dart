import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/context_util.dart';
import 'package:mobile_assessment/common/theme/app_theme.dart';
import 'package:mobile_assessment/modules/details/presentation/details_screen.dart';
import 'package:mobile_assessment/modules/home/bottom_modal.dart';
import 'package:mobile_assessment/modules/new_employee/presentation/new_employee_screen.dart';
import 'package:mobile_assessment/modules/widgets/inputs/app_textfield.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../details/state/employees_state.dart';
import '../../widgets/employee_tile.dart';
import '../../widgets/widget_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.themeProvider});

  final ThemeProvider themeProvider;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final EmployeesState _employeesState = EmployeesState()..fetchEmployees();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employees"),
        actions: [
          IconButton(
              onPressed: () => widget.themeProvider.toggleTheme(),
              icon: widget.themeProvider.isDarkTheme
                  ? Icon(Icons.light_mode_rounded)
                  : Icon(Icons.dark_mode_rounded)),
          IconButton(
              onPressed: () => context.push(NewEmployeeScreen(
                    employeesState: _employeesState,
                  )),
              icon: Icon(Icons.add_circle_outline_rounded))
        ],
      ),
      body: ListenableBuilder(
        listenable: _employeesState,
        builder: (context, _) => ErrorAndDataHandlerScreen(
          response: _employeesState.response,
          isLoading: _employeesState.isLoading,
          loading: Skeletonizer(
            child: Column(
              children: List.generate(
                8,
                (_) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SampleEmployeeTile(),
                ),
              ),
            ),
          ),
          errorWidget: (value) {
            return Center(
              child: Text(value.first.message),
            );
          },
          widgetBuilder: (_) {
            return Column(
              children: [
                Container(
                  height: 80,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Expanded(
                          child:
                              SearchTextField(employeesState: _employeesState),
                        ),
                        IconButton(
                            onPressed: () => showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return BottomModal(
                                      employeesState: _employeesState,
                                    );
                                  },
                                ),
                            icon: Icon(Icons.filter_list_rounded))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    itemBuilder: (context, index) {
                      final currentEmployee = _employeesState.employees[index];

                      return EmployeeTile(
                        onTap: () => context
                            .push(DetailsScreen(employee: currentEmployee)),
                        employee: currentEmployee,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
                    itemCount: _employeesState.employees.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
