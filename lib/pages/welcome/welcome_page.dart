import 'package:flutter/material.dart';
import 'package:plibrary/pages/sign_in/view/sign_in_page.dart';
import 'package:plibrary/pages/sign_up/view/sign_up_page.dart';
import 'package:plibrary/widgets/main_button.dart';
import 'package:plibrary/widgets/main_logo_hero.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: WelcomePage());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const WelcomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: MainLogoHero(size: 200.0),
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
