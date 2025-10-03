import 'package:flutter/material.dart';

import '../../colors/my_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final String labelText;
  final List<String> items;
  final void Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.labelText,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(

      value: value,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.primaryColor, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black87),
        ),
      ),
      hint: Text(labelText),
      isExpanded: true,
      iconSize: 30.0,
      items: items.map((val) {
        return DropdownMenuItem<String>(value: val, child: Text(val));
      }).toList(),
      onChanged: onChanged,
    );
  }
}
