import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/app/app.dart';
import 'package:plibrary/themes.dart';

import '../navigation_drawer/navigation_drawer.dart';

class NavDrawerWidget extends StatelessWidget {
  // final String accountName;
  final String accountEmail;

  final List<_NavigationItem> _listItems = [
    _NavigationItem(null, null, null, type: NavigationItemType.header),
    _NavigationItem(NavItem.home, "Home", Icons.home),
    _NavigationItem(null, null, null, type: NavigationItemType.divider),
    _NavigationItem(NavItem.movies, "Movies", Icons.movie),
    _NavigationItem(NavItem.series, "Series", Icons.auto_awesome_motion),
    _NavigationItem(NavItem.books, "Books", Icons.menu_book),
    _NavigationItem(NavItem.games, "Games", Icons.gamepad),
    _NavigationItem(null, null, null, type: NavigationItemType.divider),
    _NavigationItem(NavItem.settings, "Settings", Icons.settings),
    _NavigationItem(null, "Log Out", Icons.logout,
        type: NavigationItemType.logout)
  ];

  NavDrawerWidget(this.accountEmail);

  @override
  Widget build(BuildContext context) => Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: Container(
        color: primaryColor,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _listItems.length,
            itemBuilder: (BuildContext context, int index) =>
                BlocBuilder<NavDrawerBloc, NavDrawerState>(
                  builder: (BuildContext context, NavDrawerState state) =>
                      _buildItem(_listItems[index], state),
                )),
      ));

  Widget _buildItem(_NavigationItem data, NavDrawerState state) {
    switch (data.type) {
      case NavigationItemType.header:
        return _makeHeaderItem();
        break;
      case NavigationItemType.page:
        return _makePageItem(data, state);
        break;
      case NavigationItemType.divider:
        return Divider();
        break;
      case NavigationItemType.logout:
        return _makeLogoutItem(data);
        break;
    }
    return null;
  }

  Widget _makeHeaderItem() => UserAccountsDrawerHeader(
        accountName: Text("", style: TextStyle(color: Colors.white)),
        accountEmail: Text(accountEmail, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(color: Colors.blueGrey),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.amber,
          child: Icon(
            Icons.person,
            size: 54,
          ),
        ),
      );

  Widget _makePageItem(_NavigationItem data, NavDrawerState state) => Card(
        color: data.item == state.selectedItem ? accentColor : primaryColor,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        // So we see the selected highlight
        borderOnForeground: true,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Builder(
          builder: (BuildContext context) => ListTile(
            title: Text(
              data.title,
              style: TextStyle(
                color: data.item == state.selectedItem
                    ? Colors.blue
                    : Colors.blueGrey,
              ),
            ),
            leading: Icon(
              data.icon,
              // if it's selected change the color
              color: data.item == state.selectedItem
                  ? Colors.blue
                  : Colors.blueGrey,
            ),
            onTap: () => _handleItemClick(context, data.item),
          ),
        ),
      );

  void _handleItemClick(BuildContext context, NavItem item) {
    BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }

  Widget _makeLogoutItem(_NavigationItem data) => Card(
        color: primaryColor,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        // So we see the selected highlight
        borderOnForeground: true,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Builder(
          builder: (BuildContext context) => ListTile(
            title: Text(
              data.title,
            ),
            leading: Icon(
              data.icon,
            ),
            onTap: () => _handleLogoutClick(context),
          ),
        ),
      );

  void _handleLogoutClick(BuildContext context) {
    BlocProvider.of<AppBloc>(context).add(AppLogoutRequested());
    //Navigator.pop(context);
  }
}

// helper class used to represent navigation list items
class _NavigationItem {
  final NavigationItemType type;
  final NavItem item;
  final String title;
  final IconData icon;
  _NavigationItem(this.item, this.title, this.icon,
      {this.type = NavigationItemType.page});
}

enum NavigationItemType { header, page, divider, logout }
