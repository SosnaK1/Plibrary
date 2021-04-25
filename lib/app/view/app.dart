import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/pages/drawer_container.dart/drawer_container.dart';
import 'package:plibrary/pages/splash/splash_page.dart';
import 'package:plibrary/pages/welcome/welcome_page.dart';
import 'package:plibrary/themes.dart';

import '../app.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: RepositoryProvider(
          create: (context) => DatabaseRepository(_authenticationRepository, FirebaseFirestore.instance),
          child: AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: theme,
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            switch (state.status) {
              case AppStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  DrawerContainer.route(),
                  (route) => false,
                );
                break;
              case AppStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  WelcomePage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (settings) {
        // TODO: Fix this
        print("Route Generator Called");
        return SplashPage.route();
      },
    );
  }
}
