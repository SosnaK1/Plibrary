import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/database_service/models.dart';
import 'package:plibrary/pages/item/cubit/item_cubit.dart';
import 'package:plibrary/themes.dart';
import 'package:plibrary/widgets/default_text_form_field.dart';

enum EditableFieldType { title, author, genre, description }

Future<void> displayTextInputDialog(BuildContext context, ItemState state,
    String initialValue, String title, EditableFieldType fieldType) async {
  return showDialog(
      context: context,
      builder: (context1) {
        return AlertDialog(
          title: Text(title),
          content: fieldType != EditableFieldType.genre
              ? DefaultTextFormField(
                  initialValue: initialValue,
                  labelText: title,
                  onChanged: (value) {
                    _handleDialogFieldChanged(context, fieldType, value);
                  },
                  multiline:
                      fieldType == EditableFieldType.description ? true : false,
                )
              : DropdownButton<String>(
                  hint: Text("Genre"),
                  onChanged: (String value) {
                    _handleDialogFieldChanged(context, fieldType, value);
                    Navigator.pop(context);
                    context.read<ItemCubit>().dialogConfirmedChange(fieldType);
                  },
                  value: initialValue,
                  items: getDropdownMenuItems(state)),
          actions: fieldType == EditableFieldType.genre
              ? null
              : <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(accentColorDark)),
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(accentColorDark)),
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                      context
                          .read<ItemCubit>()
                          .dialogConfirmedChange(fieldType);
                    },
                  ),
                ],
        );
      });
}

List<DropdownMenuItem<String>> getDropdownMenuItems(ItemState state) {
  if (state.item.itemName == "movie") {
    return MovieGenre.values
        .map((genre) => DropdownMenuItem(
              value: genre.toShortString(),
              child: Text(genre.toShortString()),
            ))
        .toList();
  }

  if (state.item.itemName == "series") {
    return SeriesGenre.values
        .map((genre) => DropdownMenuItem(
              value: genre.toShortString(),
              child: Text(genre.toShortString()),
            ))
        .toList();
  }

  if (state.item.itemName == "book") {
    return BookGenre.values
        .map((genre) => DropdownMenuItem(
              value: genre.toShortString(),
              child: Text(genre.toShortString()),
            ))
        .toList();
  }

  if (state.item.itemName == "game") {
    return GameGenre.values
        .map((genre) => DropdownMenuItem(
              value: genre.toShortString(),
              child: Text(genre.toShortString()),
            ))
        .toList();
  }

  return null;
}

void _handleDialogFieldChanged(
    BuildContext context, EditableFieldType fieldType, String value) {
  var itemCubit = context.read<ItemCubit>();

  switch (fieldType) {
    case EditableFieldType.title:
      itemCubit.dialogTitleChanged(value);
      break;
    case EditableFieldType.author:
      itemCubit.dialogAuthorChanged(value);
      break;
    case EditableFieldType.genre:
      itemCubit.dialogGenreChanged(value);
      break;
    case EditableFieldType.description:
      itemCubit.dialogDescriptionChanged(value);
      break;
  }
}
