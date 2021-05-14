import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plibrary/app/app.dart';
import 'package:plibrary/pages/drawer_container/drawer_container.dart';
import 'package:plibrary/themes.dart';
import 'package:plibrary/widgets/main_logo_hero.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Observe this solution.
    Future.delayed(Duration(milliseconds: 50), () {
      if (BlocProvider.of<AppBloc>(context).state.status ==
          AppStatus.authenticated) {
        Navigator.pushAndRemoveUntil(
            context, DrawerContainer.route(), (route) => false);
      }
    });

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
