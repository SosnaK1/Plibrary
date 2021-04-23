import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:plibrary/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:plibrary/utils/toast_utils.dart';
import 'package:plibrary/widgets/back_button.dart';
import 'package:plibrary/widgets/default_text_form_field.dart';
import 'package:plibrary/widgets/main_button.dart';
import 'package:plibrary/widgets/main_logo_hero.dart';

import '../../../themes.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionFailure) {
          ToastUtils.showCustomToast(context, "Authentication Failed");
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Stack(children: [
            LoginBackButton(),
            Center(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MainLogoHero(),
                  Column(
                    children: [
                      DefaultTextFormField(
                        labelText: "Email",
                        onChanged: (email) =>
                            context.read<SignInCubit>().emailChanged(email),
                        errorText: state.email.invalid ? 'invalid email' : null,
                      ),
                      SizedBox(height: 15),
                      DefaultTextFormField(
                        labelText: "Password",
                        obscureText: true,
                        onChanged: (password) => context
                            .read<SignInCubit>()
                            .passwordChanged(password),
                        errorText: state.password.invalid
                            ? 'invalid password (at least 6 signs)'
                            : null,
                      ),
                    ],
                  ),
                  MainButton(
                    child: !state.status.isSubmissionInProgress
                        ? Text("Sign In".toUpperCase())
                        : SpinKitWave(color: accentColorDark, size: 30.0),
                    onPressed: () async {
                      if (!state.status.isValid) {
                        ToastUtils.showCustomToast(
                            context, "Please fill all the fields");
                      } else if (state.status.isValidated) {
                        BlocProvider.of<SignInCubit>(context)
                            .logInWithCredentials();
                      }
                    },
                  )
                ],
              ),
            )),
          ]),
        );
      },
    ));
  }
}
