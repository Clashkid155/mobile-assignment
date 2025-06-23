import 'package:flutter/material.dart';
import 'package:mobile_assessment/model/employee.dart';
import 'package:mobile_assessment/modules/widgets/initial_icon.dart';

class EmployeeTile extends StatelessWidget {
  const EmployeeTile({super.key, required this.employee, this.onTap});

  final Employee employee;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
          height: 50,
          width: 50,
          child: InitialIcon(initials: employee.avatarInitials)),
      onTap: onTap,
      // tileColor: Colors.orangeAccent,
      tileColor: Theme.of(context).secondaryHeaderColor,
      title: Text(employee.fullName),
      subtitle: Text("${employee.designation} - Level: ${employee.level}"),
    );
  }
}

class SampleEmployeeTile extends EmployeeTile {
  SampleEmployeeTile({super.key})
      : super(
            employee: Employee(
                id: 1,
                firstName: "firstName",
                lastName: "lastName",
                designation: "designation",
                productivityScore: 1,
                currentSalary: "1000",
                level: 1,
                employmentStatus: 1));
}
