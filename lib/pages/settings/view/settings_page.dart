import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/app/app.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/pages/settings/cubit/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
        create: (context) => SettingsCubit(context.read<DatabaseRepository>()),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Center(
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  ListTile(
                    tileColor: Colors.grey[900],
                    title: Text("Remove Movies Data",
                        style: TextStyle(color: Colors.blue)),
                    onTap: () {
                      context.read<SettingsCubit>().removeMoviesData();
                    },
                  ),
                  ListTile(
                    tileColor: Colors.grey[900],
                    title: Text("Remove Series Data",
                        style: TextStyle(color: Colors.blue)),
                    onTap: () {
                      context.read<SettingsCubit>().removeSeriesData();
                    },
                  ),
                  ListTile(
                    tileColor: Colors.grey[900],
                    title: Text("Remove Books Data",
                        style: TextStyle(color: Colors.blue)),
                    onTap: () {
                      context.read<SettingsCubit>().removeBooksData();
                    },
                  ),
                  ListTile(
                    tileColor: Colors.grey[900],
                    title: Text("Remove Games Data",
                        style: TextStyle(color: Colors.blue)),
                    onTap: () {
                      context.read<SettingsCubit>().removeGamesData();
                    },
                  ),
                  ListTile(
                    tileColor: Colors.grey[900],
                    title: Text("Remove All Data",
                        style: TextStyle(color: Colors.blue)),
                    onTap: () {
                      context.read<SettingsCubit>().removeAllData();
                    },
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    tileColor: Colors.grey[900],
                    title: Text("Delete User",
                        style: TextStyle(color: Colors.redAccent)),
                    onTap: () {
                      context.read<AppBloc>().add(AppUserDeleteRequested());
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          },
        ));
  }
}
