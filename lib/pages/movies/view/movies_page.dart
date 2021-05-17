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

                            return ListView.separated(
                                itemBuilder: (context, i) {
                                  return Dismissible(
                                    key: Key(filteredMovies[i].uuid),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        snapshot.data.remove(filteredMovies[i]);
                                        context
                                            .read<MoviesCubit>()
                                            .deleteMovieFromDB(
                                                filteredMovies[i]);
                                      }
                                    },
                                    // TODO: confirmDismiss: ,
                                    background: Container(
                                        color: Colors.red,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: Icon(Icons.delete)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(context,
                                              ItemPage.route(filteredMovies[i]));
                                        },
                                        trailing: filteredMovies[i].finished
                                            ? _getTrailingWidget(
                                                filteredMovies[i])
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Icon(Icons.visibility_off),
                                              ),
                                        title: Text(filteredMovies[i].title, style: TextStyle(fontSize: 20),),
                                        subtitle:
                                            Text(filteredMovies[i].director),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(color: Colors.grey[400], height: 0,);
                                },
                                itemCount: filteredMovies.length);
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

Widget _getTrailingWidget(Movie movie) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
        color: _getColorByScore(movie.score.toInt()),
        borderRadius: BorderRadius.circular(10)),
    child: Center(
      child: Text(
        movie.score.toInt().toString(),
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    ),
  );
}

Color _getColorByScore(int score) {
  if (score == 5) return Colors.green;
  if (score == 4) return Colors.teal[400];
  if (score == 3) return Colors.yellow;
  if (score == 2) return Colors.orange;
  if (score == 1) return Colors.red;
  return Colors.red[900];
}
