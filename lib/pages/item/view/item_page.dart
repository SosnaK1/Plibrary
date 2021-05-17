import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models.dart';
import 'package:plibrary/database_service/models/library_item.dart';
import 'package:plibrary/pages/item/cubit/item_cubit.dart';
import 'package:plibrary/utils/string_utils.dart';
import 'package:plibrary/utils/toast_utils.dart';
import 'package:plibrary/widgets/text_input_dialog.dart';

import '../../../themes.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({Key key, this.item}) : super(key: key);

  final LibraryItem item;

  static Route route(LibraryItem item) {
    return MaterialPageRoute<void>(builder: (_) => ItemPage(item: item));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemCubit>(
        create: (context) =>
            ItemCubit(context.read<DatabaseRepository>(), item),
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
              body: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    GestureDetector(
                        onLongPress: () {
                          displayTextInputDialog(
                              context,
                              state,
                              state.item.title,
                              "Title",
                              EditableFieldType.title);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(getItemTitle(state.item),
                              style: TextStyle(fontSize: 30)),
                        )),
                    SizedBox(height: 10),
                    Divider(thickness: 1.5),
                    SizedBox(height: 10),
                    GestureDetector(
                      onLongPress: () {
                        displayTextInputDialog(
                            context,
                            state,
                            getItemAuthor(state.item),
                            "Author",
                            EditableFieldType.author);
                      },
                      child: Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text("Author: ",
                            style:
                                TextStyle(fontSize: 22, color: Colors.white60)),
                        Text(getItemAuthor(state.item),
                            style:
                                TextStyle(fontSize: 22, color: Colors.white60)),
                      ]),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onLongPress: () {
                        displayTextInputDialog(
                            context,
                            state,
                            getItemGenreString(state.item),
                            "Genre",
                            EditableFieldType.genre);
                      },
                      child: Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text("Genre: ",
                            style:
                                TextStyle(fontSize: 22, color: Colors.white60)),
                        Text(getItemGenreString(state.item),
                            style:
                                TextStyle(fontSize: 22, color: Colors.white60)),
                      ]),
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 1.5),
                    SizedBox(height: 10),
                    if (getItemDescription(state.item).isNotEmpty)
                      GestureDetector(
                        onLongPress: () {
                          displayTextInputDialog(
                              context,
                              state,
                              state.item.description,
                              "Description",
                              EditableFieldType.description);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(getItemDescription(state.item),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white60)),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      TextButton(
                          onPressed: () {
                            displayTextInputDialog(
                                context,
                                state,
                                state.item.description,
                                "Description",
                                EditableFieldType.description);
                          },
                          child: Text("Add description")),
                    SizedBox(height: 20),
                    seenScoreWidget(context, state),
                  ],
                ),
              ),
              floatingActionButton: !state.formModified
                  ? null
                  : FloatingActionButton(
                      child: Icon(Icons.save),
                      onPressed: () async {
                        await context.read<ItemCubit>().saveChanges();
                        showSuccessToast(context, "Saved");
                      }),
            );
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

Widget seenScoreWidget(BuildContext context, ItemState state) {
  print(state.item.finished);
  return Column(
    children: [
      Text(
        "Finished",
        style: TextStyle(fontSize: 20.0),
      ),
      Checkbox(
          value: state.item.finished,
          onChanged: (value) {
            context.read<ItemCubit>().finishedChanged(value);
          }),
      if (state.item.finished)
        Slider(
            activeColor: accentColor,
            max: 5.0,
            divisions: 5,
            value: state.item.score,
            onChanged: (double newValue) {
              context.read<ItemCubit>().scoreChanged(newValue);
            }),
      if (state.item.finished)
        Text(
          state.item.score.toInt().toString() + "/5",
          style: TextStyle(fontSize: 22),
        )
    ],
  );
}
