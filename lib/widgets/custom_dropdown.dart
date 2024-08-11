import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String value;
  final List list;
  final Function onChanged;
  final Color bgColor;
  final Color textColor;
  final bool showBorderColor;

  const CustomDropdown(
      {super.key,
      required this.value,
      required this.list,
      required this.onChanged,
      this.bgColor = Colors.white,
      this.textColor = Colors.black,
      this.showBorderColor = true});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: widget.bgColor,
        border: widget.showBorderColor
            ? Border.all(
                color: Colors.grey.shade700,
              )
            : null,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: DropdownButton<String>(
          dropdownColor: widget.bgColor,
          isExpanded: true,
          underline: Container(),
          value: widget.value,
          icon: const Icon(Icons.expand_more),
          iconEnabledColor: widget.textColor,
          items: [
            DropdownMenuItem(
              value: "",
              child: Text(
                "Select Land Type",
                style: TextStyle(
                  fontSize: 14,
                  color: widget.textColor,
                ),
              ),
            ),
            for (var dropdown in widget.list)
              DropdownMenuItem(
                value: dropdown['id'].toString(),
                child: Text(
                  dropdown['name'],
                  style: TextStyle(
                      fontSize: 14,
                      color: widget.textColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
          ],
          onChanged: (value) {
            widget.onChanged(value);
          }),
    );
  }
}
