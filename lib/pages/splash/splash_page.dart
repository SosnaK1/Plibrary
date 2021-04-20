import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plibrary/themes.dart';
import 'package:plibrary/widgets/main_logo_hero.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainLogoHero(),
          SizedBox(height: 50),
          SpinKitWave(color: accentColorDark),
        ],
      )),
    );
  }
}
