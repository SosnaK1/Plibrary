import 'package:flutter/material.dart';
import 'package:plibrary/navigation_drawer/navigation_drawer.dart';
import 'package:plibrary/pages/new_item/view/new_item_page.dart';

class BooksPage extends StatelessWidget {

  FloatingActionButton booksFAB(BuildContext context) => FloatingActionButton(
    onPressed: () {
      Navigator.push(context, NewItemPage.route(NavItem.books));
    },
    child: Icon(Icons.add),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Books!"),
    );
  }
}