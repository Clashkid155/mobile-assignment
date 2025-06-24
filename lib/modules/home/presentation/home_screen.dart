import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/context_util.dart';
import 'package:mobile_assessment/common/theme/app_theme.dart';
import 'package:mobile_assessment/modules/details/presentation/details_screen.dart';
import 'package:mobile_assessment/modules/home/bottom_modal.dart';
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
              onPressed: () {
                widget.themeProvider.toggleTheme();
              },
              icon: widget.themeProvider.isDarkTheme
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
                            Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                  borderRadius:
                                      BorderRadiusGeometry.circular(10),
                                  border: Border.all(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                            ),
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return BottomModal(
                                        employeesState: _employeesState,
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.filter_list_rounded))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // final currentEmployee = value!.employees[index];
                          final currentEmployee =
                              _employeesState.employees[index];

                          return EmployeeTile(
                            onTap: () => context
                                .push(DetailsScreen(employee: currentEmployee)),
                            employee: currentEmployee,
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8,
                        ),
                        itemCount: _employeesState.employees.length ?? 0,
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
