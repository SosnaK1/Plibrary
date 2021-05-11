import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/movie.dart';
import 'package:plibrary/pages/new_item/cubit/new_item_cubit.dart';
import 'package:plibrary/utils/toast_utils.dart';
import 'package:plibrary/widgets/default_text_form_field.dart';
import 'package:plibrary/widgets/main_button.dart';
import 'package:formz/formz.dart';

import '../../../themes.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const NewItemPage());
  }

  @override
  _NewItemPageState createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final ImagePicker _picker = ImagePicker();

  Future<String> _imgFromGallery() async {
    PickedFile imageFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    return imageFile.path;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewItemCubit(context.read<DatabaseRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("New Item"),
        ),
        body: BlocConsumer<NewItemCubit, NewItemState>(
          listener: (context, state) {
            if (state.status == FormzStatus.submissionFailure) {
              showErrorToast(context, "Authentication Failed");
            } else if (state.status == FormzStatus.submissionSuccess) {
              print("Dodano");
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Center(
              child: Padding(
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
                      DefaultTextFormField(
                        labelText: "Title",
                        onChanged: (String newValue) {
                          context.read<NewItemCubit>().titleChanged(newValue);
                        },
                        errorText:
                            state.title.invalid ? "Invalid Title!" : null,
                      ),
                      DefaultTextFormField(
                          labelText: "Director",
                          onChanged: (String newValue) {
                            context
                                .read<NewItemCubit>()
                                .directorChanged(newValue);
                          }),
                      Slider(
                          activeColor: accentColor,
                          max: 5.0,
                          divisions: 5,
                          value: state.score,
                          onChanged: (double newValue) {
                            context.read<NewItemCubit>().scoreChanged(newValue);
                          }),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // if (state.imagePath != "")
                      //   Image.file(
                      //     File(state.imagePath),
                      //     height: 80,
                      //     width: 80,
                      //   ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // MainButton(
                      //   child: Text("Choose image".toUpperCase()),
                      //   onPressed: () async {
                      //     String path = await _imgFromGallery();
                      //     context.read<NewItemCubit>().imagePicked(path);
                      //   },
                      // ),
                      SizedBox(
                        height: 40,
                      ),
                      MainButton(
                        child: !state.status.isSubmissionInProgress
                            ? Text("Add".toUpperCase())
                            : SpinKitWave(color: accentColorDark, size: 30.0),
                        onPressed: () async {
                          if (!state.status.isValid) {
                            showErrorToast(
                                context, "Please fill all the fields");
                          } else if (state.status.isValidated) {
                            context.read<NewItemCubit>().newItemSubmitted();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
