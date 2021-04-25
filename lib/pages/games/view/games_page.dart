import 'package:flutter/material.dart';
import 'package:plibrary/pages/new_item/view/new_item_page.dart';

class GamesPage extends StatelessWidget {

  FloatingActionButton gamesFAB(BuildContext context) => FloatingActionButton(
    onPressed: () {
      Navigator.push(context, NewItemPage.route());
    },
    child: Icon(Icons.add),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Games!"),
    );
  }
}