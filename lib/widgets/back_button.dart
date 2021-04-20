import 'package:flutter/material.dart';

class LoginBackButton extends StatelessWidget {
  final BuildContext context;

  const LoginBackButton({Key key, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
