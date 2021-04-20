import 'package:flutter/material.dart';
import '../themes.dart';

class DefaultTextFormField extends StatelessWidget {
  final String labelText;
  final String errorText;
  final bool obscureText;
  final Function(String) onChanged;

  const DefaultTextFormField(
      {Key key,
      this.labelText,
      this.obscureText=false,
      this.onChanged,
      this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
      decoration: InputDecoration(
          errorText: errorText,
          labelText: labelText,
          labelStyle: TextStyle(
            color: accentColorLight,
          ),
          helperText: ' ', // Helps with error text changing widget size
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: accentColorLight),
              borderRadius: BorderRadius.all(Radius.circular(8.0)))),
    );
  }
}
