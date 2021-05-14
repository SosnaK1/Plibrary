import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/database_service/models.dart';
import 'package:plibrary/database_service/models/library_item.dart';
import 'package:plibrary/pages/item/cubit/item_cubit.dart';
import 'package:plibrary/utils/string_utils.dart';
import 'package:plibrary/utils/toast_utils.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({Key key, this.item}) : super(key: key);

  final LibraryItem item;

  static Route route(LibraryItem item) {
    return MaterialPageRoute<void>(builder: (_) => ItemPage(item: item));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemCubit>(
        create: (context) => ItemCubit(item),
        child: BlocConsumer<ItemCubit, ItemState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(state.item.itemName.capitalize()),
                  actions: [
                    IconButton(
                        onPressed: () {
                          showInformationToast(
                              context, "Long press on a field to edit it");
                        },
                        icon: Icon(Icons.edit))
                  ],
                ),
                body: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(getItemTitle(item), style: TextStyle(fontSize: 30)),
                      SizedBox(height: 10),
                      Divider(thickness: 1.5),
                      SizedBox(height: 10),
                      Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text("Author: ",
                            style:
                                TextStyle(fontSize: 22, color: Colors.white60)),
                        Text(getItemAuthor(item),
                            style:
                                TextStyle(fontSize: 22, color: Colors.white60)),
                      ]),
                      SizedBox(height: 10),
                      Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text("Genre: ",
                            style:
                                TextStyle(fontSize: 22, color: Colors.white60)),
                        Text(getItemGenreString(item),
                            style:
                                TextStyle(fontSize: 22, color: Colors.white60)),
                      ]),
                      SizedBox(height: 10),
                      Divider(thickness: 1.5),
                      SizedBox(height: 10),
                      if (getItemDescription(item).length > 0)
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(getItemDescription(item),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white60)),
                            )
                          ],
                        )
                    ],
                  ),
                ));
          },
        ));
  }
}

String getItemTitle(LibraryItem item) {
  if (item is Movie) return item.title;
  if (item is Series) return item.title;
  if (item is Book) return item.title;
  if (item is Game) return item.title;
  return "";
}

String getItemAuthor(LibraryItem item) {
  if (item is Movie) return item.director;
  if (item is Series) return item.director;
  if (item is Book) return item.author;
  if (item is Game) return item.studio;
  return "";
}

String getItemGenreString(LibraryItem item) {
  if (item is Movie) return item.genre.toShortString();
  if (item is Series) return item.genre.toShortString();
  if (item is Book) return item.genre.toShortString();
  if (item is Game) return item.genre.toShortString();
  return "";
}

String getItemDescription(LibraryItem item) {
  if (item is Movie) return item.description;
  if (item is Series) return item.description;
  if (item is Book) return item.description;
  if (item is Game) return item.description;
  return "";
}
