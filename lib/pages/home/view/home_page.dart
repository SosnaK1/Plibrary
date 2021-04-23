import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/app/app.dart';
import 'package:plibrary/navigation_drawer/nav_drawer_widget.dart';
import 'package:plibrary/navigation_drawer/navigation_drawer.dart';
import 'package:plibrary/pages/home/cubit/home_cubit.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: HomePage());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavDrawerBloc>(
        create: (_) => NavDrawerBloc(),
        child: BlocBuilder<NavDrawerBloc, NavDrawerState>(
            builder: (context, state) {
          return Scaffold(
              drawer: NavDrawerWidget(BlocProvider.of<AppBloc>(context).state.user.email),
              appBar: AppBar(
                title: Text(state.selectedItem.toString()),
              ),
              body: _bodyForState(state));
        }));
  }
}

Widget _bodyForState(NavDrawerState state) {
  return Center(child: Text(state.selectedItem.toString()));
}
