import 'package:flutter/material.dart';
import 'package:mobile_assessment/model/employee.dart';
import 'package:mobile_assessment/modules/details/state/employees_state.dart';

import '../widgets/inputs/app_textfield.dart';

class BottomModal extends StatefulWidget {
  const BottomModal({super.key, required this.employeesState});

  final EmployeesState employeesState;

  @override
  State<BottomModal> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  final TextEditingController _byNameController = TextEditingController();

  @override
  void initState() {
    _byNameController.text = widget.employeesState.filterName;
    super.initState();
  }

  @override
  void dispose() {
    _byNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      width: double.infinity,
      child: SingleChildScrollView(
        child: ListenableBuilder(
            listenable: widget.employeesState,
            builder: (context, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter By",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      widget.employeesState.isFilterActive
                          ? ElevatedButton(
                              onPressed: () {
                                widget.employeesState.clearFilter();
                              },
                              child: Text(
                                "Clear filter",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                widget.employeesState.filterName =
                                    _byNameController.text.trim();
                                widget.employeesState.filterEmployees();
                              },
                              child: Text(
                                "Apply filter",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text("By Name"),
                    shape: Border(),
                    children: [
                      TextFormField(
                        controller: _byNameController,
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text("By Level"),
                    shape: Border(),
                    children: [
                      for (int i = 0; i < 6; i++)
                        CheckboxListTile(
                          title: Text(i.toString()),
                          value: widget.employeesState.checkedLevel[i],
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                widget.employeesState.checkedLevel[i] = value;
                              }
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                    ],
                  ),
                  ExpansionTile(
                      title: Text("By Designation"),
                      shape: Border(),
                      children: [
                        for (int i = 0; i < Designation.values.length; i++)
                          CheckboxListTile(
                            title: Text(Designation.values[i].label),
                            value: widget.employeesState.checkedDesignation[i],
                            onChanged: (bool? value) {
                              setState(() {
                                if (value != null) {
                                  widget.employeesState.checkedDesignation[i] =
                                      value;
                                }
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                      ]),
                ],
              );
            }),
      ),
    );
  }
}
