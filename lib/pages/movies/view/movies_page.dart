import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/movie.dart';
import 'package:plibrary/navigation_drawer/navigation_drawer.dart';
import 'package:plibrary/pages/item/view/item_page.dart';
import 'package:plibrary/pages/movies/cubit/movies_cubit.dart';
import 'package:plibrary/pages/new_item/view/new_item_page.dart';
import 'package:plibrary/themes.dart';
import 'package:plibrary/utils/item_sort_utils.dart';
import 'package:shimmer/shimmer.dart';

class MoviesPage extends StatelessWidget {
  FloatingActionButton moviesFAB(BuildContext context) => FloatingActionButton(
        onPressed: () {
          Navigator.push(context, NewItemPage.route(NavItem.movies));
        },
        child: Icon(Icons.add),
      );

  MoviesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();

    return BlocProvider(
        create: (context) => MoviesCubit(context.read<DatabaseRepository>()),
        child: BlocConsumer<MoviesCubit, MoviesState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  if (context.read<NavDrawerBloc>().state.searchFieldRevealed)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 14),
                      child: Stack(
                        children: [
                          BlocListener<NavDrawerBloc, NavDrawerState>(
                            listenWhen: (a, b) =>
                                a.searchFieldRevealed != b.searchFieldRevealed,
                            listener: (context, state) {
                              context
                                  .read<MoviesCubit>()
                                  .searchFilterChanged("");
                            },
                            child: TextFormField(
                              controller: controller,
                              onChanged: (String value) {
                                context
                                    .read<MoviesCubit>()
                                    .searchFilterChanged(value);
                              },
                              cursorColor: Theme.of(context)
                                  .textSelectionTheme
                                  .cursorColor,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: accentColor),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: accentColor),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: accentColor),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: () {
                                  context
                                      .read<MoviesCubit>()
                                      .searchFilterChanged("");
                                  controller.clear();
                                },
                                icon: Icon(Icons.clear)),
                          )
                        ],
                      ),
                    ),
                  Expanded(
                    child: StreamBuilder<List<Movie>>(
                      stream: state.moviesStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Movie>> snapshot) {
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Column(children: [
                              LinearProgressIndicator(),
                              shimmerListItem,
                              shimmerListItem,
                              shimmerListItem,
                            ]);
                          default:
                            var movies = snapshot.data;

                            List<Movie> filteredMovies = [];

                            if (state.searchFilter.isNotEmpty)
                              filteredMovies =
                                  filterMovies(movies, state.searchFilter);
                            else
                              filteredMovies = movies;

                            filteredMovies.sort(getSortingFunction(
                                BlocProvider.of<NavDrawerBloc>(context)
                                    .state
                                    .sortOption));

                            return ListView(
                              children: filteredMovies.map((Movie movie) {
                                return Dismissible(
                                  key: Key(movie.uuid),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      snapshot.data.remove(movie);
                                      context
                                          .read<MoviesCubit>()
                                          .deleteMovieFromDB(movie);
                                    }
                                  },
                                  // TODO: confirmDismiss: ,
                                  background: Container(
                                      color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Icon(Icons.delete)),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context, ItemPage.route(movie));
                                    },
                                    // trailing: movie.image != null
                                    //     ? Image.file(File(movie.image))
                                    //     : null,
                                    title: Text(movie.title),
                                    subtitle: Text(movie.director),
                                  ),
                                );
                              }).toList(),
                            );
                        }
                      },
                    ),
                  ),
                ],
              );
            }));
  }

  List<Movie> filterMovies(List<Movie> movies, String filter) {
    List<Movie> filteredMovies = [];

    for (var i = 0; i < movies.length; i++) {
      if (movies[i].title.contains(filter)) {
        filteredMovies.add(movies[i]);
        continue;
      }
      if (movies[i].director.contains(filter)) {
        filteredMovies.add(movies[i]);
        continue;
      }
      if (movies[i].genre.toShortString().contains(filter)) {
        filteredMovies.add(movies[i]);
        continue;
      }
    }
    return filteredMovies;
  }
}

Widget shimmerListItem = Padding(
    padding: EdgeInsets.all(20),
    child: Row(children: [
      Shimmer.fromColors(
          baseColor: Colors.grey[700],
          highlightColor: Colors.grey[800],
          child: Container(height: 40, width: 40, color: Colors.black)),
      SizedBox(width: 20),
      Expanded(
        child: SizedBox(
          height: 45,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                  baseColor: Colors.grey[700],
                  highlightColor: Colors.grey[800],
                  child: Container(height: 10, width: 80, color: Colors.black)),
              Shimmer.fromColors(
                  baseColor: Colors.grey[700],
                  highlightColor: Colors.grey[800],
                  child: Container(height: 8, color: Colors.black)),
              Shimmer.fromColors(
                  baseColor: Colors.grey[700],
                  highlightColor: Colors.grey[800],
                  child: Container(height: 8, color: Colors.black)),
            ],
          ),
        ),
      )
    ]));
