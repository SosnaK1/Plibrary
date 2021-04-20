import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:plibrary/widgets/back_button.dart';
import 'package:plibrary/widgets/main_logo_hero.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Stack(children: [
            LoginBackButton(),
            Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
              children: [
                  MainLogoHero()
              ],
            ),
                )),
          ]),
        );
      },
    ));
  }
}
