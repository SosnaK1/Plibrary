import 'package:flutter/material.dart';
import 'package:plibrary/pages/sign_in/view/sign_in_page.dart';
import 'package:plibrary/pages/sign_up/view/sign_up_page.dart';
import 'package:plibrary/widgets/main_button.dart';

class WelcomePage extends StatelessWidget {
  static Page page() => MaterialPage<void>(child: WelcomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: FlutterLogo(style: FlutterLogoStyle.stacked, size: 200),
                flex: 4),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _SignInButton(),
                  SizedBox(height: 30),
                  _SignUpButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MainButton(
        onPressed: () {
          Navigator.push(context, SignInPage.route());
        },
        child: Text("Sign In".toUpperCase()),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MainButton(
        onPressed: () {
          Navigator.push(context, SignUpPage.route());
        },
        child: Text("Sign Up".toUpperCase()),
      ),
    );
  }
}
