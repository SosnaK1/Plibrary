import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/pages/sign_up/cubit/sign_up_cubit.dart';
import 'package:plibrary/pages/sign_up/view/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: SignUpPage());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
          child: SignUpForm(),
        ),
      ),
    );
  }
}