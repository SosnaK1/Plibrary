import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/pages/new_item/cubit/new_item_cubit.dart';

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
            return Column(
              children: [
                Center(
                    child: DropdownButton<String>(
                  onChanged: (String newValue) {
                    print(newValue);
                  },
                  value: "Movie",
                  items: <String>['Movie', 'Series', 'Book', 'Game']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
                ElevatedButton(
                    onPressed: () {
                      context.read<NewItemCubit>().newItemSubmitted();
                    },
                    child: Text("Add"))
              ],
            );
          },
        ),
      ),
    );
  }
}
