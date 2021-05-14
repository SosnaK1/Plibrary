import 'package:flutter/material.dart';
import '../themes.dart';

class DefaultTextFormField extends StatelessWidget {
  final String initialValue;
  final String labelText;
  final String errorText;
  final bool obscureText;
  final Function(String) onChanged;

  final bool multiline;
  final int maxLength;

  const DefaultTextFormField(
      {Key key,
      this.initialValue,
      this.labelText,
      this.obscureText = false,
      this.onChanged,
      this.errorText,
      this.multiline = false,
      this.maxLength = 300})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!this.multiline) {
      return TextFormField(
        initialValue: initialValue,
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
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      );
    } else {
      return TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        maxLength: 300,
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
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      );
    }
  }
}
