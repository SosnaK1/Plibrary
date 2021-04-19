import 'package:flutter/material.dart';
import 'package:plibrary/themes.dart';

class MainButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color color;
  final Color textColor;

  MainButton({this.onPressed, this.child, this.color = accentColor, this.textColor = textColorOnAccent});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style:
          ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            foregroundColor: MaterialStateProperty.all<Color>(textColor),
            minimumSize: MaterialStateProperty.all<Size>(Size(240, 50)),
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            )),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              )
            )
          ),
    );
  }
}
