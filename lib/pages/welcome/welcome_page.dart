import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {

  static Page page() => MaterialPage<void>(child: WelcomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("OK")),
    );
  }
}
