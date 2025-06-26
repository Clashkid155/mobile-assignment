import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../details/state/employees_state.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.headerText,
      required this.placeholderText,
      this.validator,
      this.textInputAction = TextInputAction.next,
      this.keyboardType,
      this.maxLength,
      this.inputFormatters,
      this.onChanged});

  final TextEditingController controller;
  final String headerText;
  final String placeholderText;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.headerText,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        TextFormField(
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          controller: widget.controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide()),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide()),
              hintText: widget.placeholderText,
              hintStyle: TextStyle(
                  // color: AppColor.textHint,
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.employeesState});

  final EmployeesState employeesState;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        employeesState.searchByNameOrDesignation(value);
      },
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white54
                : Colors.black54,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
