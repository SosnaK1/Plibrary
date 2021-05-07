import 'package:animated_text_kit/animated_text_kit.dart';
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              Expanded(
                child: MainLogoHero(size: 200.0),
                flex: 1,
              ),
              Expanded(
                  child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                FlickerAnimatedText('PLibrary',
                    textStyle: TextStyle(
                      fontSize: 44,
                      shadows: [
                        Shadow(
                          blurRadius: 7.0,
                          color: Colors.white,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    speed: Duration(seconds: 3))
              ]), flex: 1,),
              Expanded(
                flex: 1,
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
