import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/movie.dart';
import 'package:plibrary/navigation_drawer/navigation_drawer.dart';
import 'package:plibrary/pages/new_item/cubit/new_item_cubit.dart';
import 'package:plibrary/utils/categories_utils.dart';
import 'package:plibrary/utils/toast_utils.dart';
import 'package:plibrary/widgets/default_text_form_field.dart';
import 'package:plibrary/widgets/main_button.dart';
import 'package:formz/formz.dart';

import '../../../themes.dart';

class NewItemPage extends StatefulWidget {
  NewItemPage(this.itemType, {Key key}) : super(key: key);

  final NavItem itemType;

  static Route route(NavItem itemType) {
    return MaterialPageRoute<void>(builder: (_) => NewItemPage(itemType));
  }

  @override
  _NewItemPageState createState() => _NewItemPageState(itemType);
}

class _NewItemPageState extends State<NewItemPage> {
  _NewItemPageState(this.itemType);

  NavItem itemType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewItemCubit(
          context.read<DatabaseRepository>(), getItemTypeName(itemType)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("New Item"),
        ),
        body: BlocConsumer<NewItemCubit, NewItemState>(
          listener: (context, state) {
            if (state.status == FormzStatus.submissionFailure) {
              showErrorToast(context, "Couldn't add new item!");
            } else if (state.status == FormzStatus.submissionSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButton<String>(
                      hint: Text("Item Type"),
                      onChanged: (String newValue) {
                        context
                            .read<NewItemCubit>()
                            .selectedItemTypeChanged(newValue);
                      },
                      value: state.selectedItemType,
                      items: NewItemState.itemTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    if (state.selectedItemType == "Movies")
                      movieFields(context, state),
                    MainButton(
                      child: !state.status.isSubmissionInProgress
                          ? Text("Add".toUpperCase())
                          : SpinKitWave(color: accentColorDark, size: 30.0),
                      onPressed: () async {
                        if (!state.status.isValid) {
                          showErrorToast(context, "Please fill all the fields");
                        } else if (state.status.isValidated) {
                          context.read<NewItemCubit>().newItemSubmitted();
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget movieFields(BuildContext context, NewItemState state) {
  return Column(
    children: [
      DefaultTextFormField(
        labelText: "Title",
        onChanged: (String newValue) {
          context.read<NewItemCubit>().movieTitleChanged(newValue);
        },
        errorText: state.movieTitle.invalid ? "Invalid Title!" : null,
      ),
      DefaultTextFormField(
          labelText: "Director",
          onChanged: (String newValue) {
            context.read<NewItemCubit>().movieDirectorChanged(newValue);
          }),
      Slider(
          activeColor: accentColor,
          max: 5.0,
          divisions: 5,
          value: state.score,
          onChanged: (double newValue) {
            context.read<NewItemCubit>().scoreChanged(newValue);
          }),
      SizedBox(
        height: 20,
      ),
      DropdownButton<String>(
          hint: Text("Item Type"),
          onChanged: (String newValue) {
            context.read<NewItemCubit>().movieGenreChanged(newValue);
          },
          value: state.movieGenre.toShortString(),
          items: MovieGenre.values
              .map((genre) => DropdownMenuItem(
                    value: genre.toShortString(),
                    child: Text(genre.toShortString()),
                  ))
              .toList()),
      SizedBox(
        height: 20,
      ),
      DefaultTextFormField(
        labelText: "Description",
        multiline: true,
        onChanged: (String newValue) {
          context.read<NewItemCubit>().movieDescriptionChanged(newValue);
        },
      ),
      SizedBox(
        height: 40,
      ),
    ],
  );
}
