import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/app/app.dart';
import 'package:plibrary/pages/books/view/books_page.dart';
import 'package:plibrary/pages/games/view/games_page.dart';
import 'package:plibrary/pages/home/view/home_page.dart';
import 'package:plibrary/pages/movies/view/movies_page.dart';
import 'package:plibrary/pages/series/view/series_page.dart';
import 'package:plibrary/pages/settings/view/settings_page.dart';
import 'package:plibrary/widgets/nav_drawer_widget.dart';
import 'package:plibrary/navigation_drawer/navigation_drawer.dart';

class DrawerContainer extends StatefulWidget {
  const DrawerContainer({Key key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: DrawerContainer());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const DrawerContainer());
  }

  @override
  _DrawerContainerState createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  NavDrawerBloc _bloc;
  Widget _content;

  @override
  void initState() {
    super.initState();
    _bloc = NavDrawerBloc();
    _content = _bodyForState(_bloc.state.selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<NavDrawerBloc>(
          create: (_) => NavDrawerBloc(),
          child: BlocConsumer<NavDrawerBloc, NavDrawerState>(
              listener: (BuildContext context, NavDrawerState state) {
            setState(() {
              _content = _bodyForState(state.selectedItem);
            });
          }, builder: (context, state) {
            return Scaffold(
                drawer: NavDrawerWidget(
                    BlocProvider.of<AppBloc>(context).state.user.email),
                appBar: AppBar(
                  title: Text(_titleForState(state.selectedItem)),
                ),
                floatingActionButton: _fabForState(state.selectedItem, context),
                body: AnimatedSwitcher(
                    switchInCurve: Curves.easeInExpo,
                    switchOutCurve: Curves.easeOutExpo,
                    duration: Duration(milliseconds: 200),
                    child: _content));
          })),
    );
  }
}

String _titleForState(NavItem state) {
  switch (state) {
    case NavItem.home:
      return "Home";
      break;
    case NavItem.movies:
      return "Movies";
      break;
    case NavItem.series:
      return "Series";
      break;
    case NavItem.books:
      return "Books";
      break;
    case NavItem.games:
      return "Games";
      break;
    case NavItem.settings:
      return "Settings";
      break;
    default:
      return null;
  }
}

Widget _bodyForState(NavItem state) {
  switch (state) {
    case NavItem.home:
      return HomePage();
      break;
    case NavItem.movies:
      return MoviesPage();
      break;
    case NavItem.series:
      return SeriesPage();
      break;
    case NavItem.books:
      return BooksPage();
      break;
    case NavItem.games:
      return GamesPage();
      break;
    case NavItem.settings:
      return SettingsPage();
      break;
    default:
      return null;
  }
}

FloatingActionButton _fabForState(NavItem state, BuildContext context) {
  switch (state) {
    case NavItem.home:
      return HomePage().homeFAB(context);
      break;
    case NavItem.movies:
      return MoviesPage().moviesFAB(context);
      break;
    case NavItem.series:
      return SeriesPage().seriesFAB(context);
      break;
    case NavItem.books:
      return BooksPage().booksFAB(context);
      break;
    case NavItem.games:
      return GamesPage().gamesFAB(context);
      break;
    default:
      return null;
  }
}
