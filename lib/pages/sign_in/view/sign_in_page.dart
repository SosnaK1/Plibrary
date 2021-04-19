import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/pages/sign_in/cubit/sign_in_cubit.dart';
import 'sign_in_form.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: SignInPage());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignInPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => SignInCubit(context.read<AuthenticationRepository>()),
          child: SignInForm(),
        ),
      ),
    );
  }
}