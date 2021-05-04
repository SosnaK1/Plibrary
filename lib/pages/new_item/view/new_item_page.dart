import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/pages/new_item/cubit/new_item_cubit.dart';
import 'package:plibrary/widgets/default_text_form_field.dart';

class NewItemPage extends StatelessWidget {
  const NewItemPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const NewItemPage());
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
          listener: (context, state) {},
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                    SizedBox(height: 40,),
                    DefaultTextFormField(
                      labelText: "Title",
                      onChanged: (String newValue) {
context
                            .read<NewItemCubit>()
                            .titleChanged(newValue);
                      },
                      errorText: "Invalid Title!",
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<NewItemCubit>().newItemSubmitted();
                        },
                        child: Text("Add"))
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
