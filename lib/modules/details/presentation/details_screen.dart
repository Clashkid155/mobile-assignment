import 'package:flutter/material.dart';
import 'package:mobile_assessment/model/employee.dart';
import 'package:mobile_assessment/modules/widgets/initial_icon.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.employee});

  final Employee employee;

  // final EmployeesState _employeesState = EmployeesState()..fetchEmployees();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(employee.fullName),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            spacing: 8,
            children: [
              SizedBox(
                height: 12,
              ),
              SizedBox(
                  height: 100,
                  width: 100,
                  child: InitialIcon(initials: employee.avatarInitials)),
              Text(
                employee.promotionStatus.label,
                style: TextStyle(
                    color: employee.promotionStatus.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadiusGeometry.circular(10)),
                child: Column(
                  spacing: 10,
                  children: [
                    customRow(
                      children: [
                        _buildHeaderText("Name"),
                        _buildNormalText(employee.fullName),
                      ],
                    ),
                    customRow(
                      children: [
                        _buildHeaderText("Designation"),
                        _buildNormalText(employee.designation),
                      ],
                    ),
                    customRow(
                      children: [
                        _buildHeaderText("Level"),
                        _buildNormalText(employee.level.toString()),
                      ],
                    ),
                    customRow(
                      children: [
                        _buildHeaderText("Productivity Score"),
                        _buildNormalText(employee.productivityScore.toString()),
                      ],
                    ),
                    customRow(
                      children: [
                        _buildHeaderText("Current Salary"),
                        _buildNormalText(employee.currentSalary),
                      ],
                    ),
                    if (employee.promotionStatus == EmploymentStatus.promoted)
                      customRow(
                        children: [
                          _buildHeaderText("New Salary"),
                          _buildNormalText(employee.newSalary),
                        ],
                      ),
                    customRow(
                      children: [
                        _buildHeaderText("Employment Status"),
                        _buildNormalText(employee.promotionStatus.label),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

Widget _buildHeaderText(String text) {
  return Text(
    text,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
  );
}

Widget _buildNormalText(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 16),
  );
}

Widget customRow({required List<Widget> children}) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );

/*ListenableBuilder(
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
                          width: 300,
                          color: Colors.green,
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
                      itemBuilder: (context, index) =>
                          EmployeeTile(employee: value!.employees[index]),
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
      ),*/
