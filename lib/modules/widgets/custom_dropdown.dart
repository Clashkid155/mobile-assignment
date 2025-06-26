import 'package:flutter/material.dart';

class AnchoredDropdown extends StatefulWidget {
  final List<String> options;
  final String? selectedValue;
  final Function(String?) onChanged;
  final String hint;

  const AnchoredDropdown({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.hint,
  });

  @override
  State<AnchoredDropdown> createState() => _AnchoredDropdownState();
}

class _AnchoredDropdownState extends State<AnchoredDropdown> {
  bool expanded = false;

  void toggleExpanded() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () async {
            toggleExpanded();
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final Size size = renderBox.size;
            final Offset offset = renderBox.localToGlobal(Offset.zero);

            final String? selectedValueResult = await showMenu<String>(
              context: context,
              position: RelativeRect.fromLTRB(
                offset.dx,
                offset.dy + size.height,
                offset.dx + size.width,
                offset.dy + size.height + 200, // Provides ample space below
              ),
              items: widget.options.map<PopupMenuItem<String>>((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: SizedBox(
                    width: size.width - 32, // Match button width minus padding
                    child: Row(
                      children: [
                        // Icon(Icons.work, size: 16, color: Colors.blue),
                        SizedBox(width: 8),
                        Expanded(child: Text(option)),
                        if (widget.selectedValue == option)
                          Icon(Icons.check, color: Colors.green, size: 16),
                      ],
                    ),
                  ),
                );
              }).toList(),
              elevation: 8,
            );

            if (selectedValueResult != null) {
              widget.onChanged(selectedValueResult);
            }
            toggleExpanded();
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selectedValue ?? widget.hint,
                  style: TextStyle(
                    color: widget.selectedValue == null
                        ? Colors.grey[600]
                        : Colors.black,
                  ),
                ),
                AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: Duration(milliseconds: 500),
                    child: Icon(Icons.arrow_drop_down_rounded)),
              ],
            ),
          ),
        );
      },
    );
  }
}
