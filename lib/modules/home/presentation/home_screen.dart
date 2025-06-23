import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/context_util.dart';
import 'package:mobile_assessment/common/theme/app_theme.dart';
import 'package:mobile_assessment/modules/details/presentation/details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../details/state/employees_state.dart';
import '../../widgets/employee_tile.dart';
import '../../widgets/widget_builder.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.themeProvider});

  final ThemeProvider themeProvider;

  final EmployeesState _employeesState = EmployeesState()..fetchEmployees();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employees"),
        actions: [
          IconButton(
              onPressed: () {
                themeProvider.toggleTheme();
              },
              icon: themeProvider.isDarkTheme
                  ? Icon(Icons.light_mode_rounded)
                  : Icon(Icons.dark_mode_rounded)),
          IconButton(
              onPressed: () {
                // context.push(DetailsScreen());
              },
              icon: Icon(Icons.add_circle_outline_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListenableBuilder(
          listenable: _employeesState,
          builder: (context, _) {
            return ErrorAndDataHandlerScreen(
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
              widgetBuilder: (value) {
                return Column(
                  children: [
                    SizedBox(
                      height: 80,
                      child: Row(
                        spacing: 8,
                        children: [
                          Container(
                            width: 250,
                            // color: Colors.green,
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 200,
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.filter_list_rounded))
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final currentEmployee = value!.employees[index];
                          return EmployeeTile(
                            onTap: () => context
                                .push(DetailsScreen(employee: currentEmployee)),
                            employee: currentEmployee,
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8,
                        ),
                        itemCount: value?.employees.length ?? 0,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ), /*Column(
          spacing: 8,
          children: [
            ListTile(
                title: Text("View Employees"),
                tileColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10)),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () => context.push(DetailsScreen())),
          ],
        ),*/
      ),
    );
  }
}
