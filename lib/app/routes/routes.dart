import 'package:flutter/widgets.dart';
import 'package:plibrary/app/bloc/app_bloc.dart';
import 'package:plibrary/pages/drawer_container/drawer_container.dart';
import 'package:plibrary/pages/welcome/welcome_page.dart';


List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [DrawerContainer.page()];
    case AppStatus.unauthenticated:
    default:
      return [WelcomePage.page()];
  }
}