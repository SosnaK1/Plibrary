import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/movie.dart';
import 'package:plibrary/pages/new_item/view/new_item_page.dart';
import 'package:plibrary/themes.dart';
import 'package:shimmer/shimmer.dart';

class MoviesPage extends StatefulWidget {
  FloatingActionButton moviesFAB(BuildContext context) => FloatingActionButton(
        onPressed: () {
          Navigator.push(context, NewItemPage.route());
        },
        child: Icon(Icons.add),
      );

  MoviesPage({Key key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  Stream<List<Movie>> _moviesStream;

  @override
  void initState() {
    super.initState();
    _moviesStream = context.read<DatabaseRepository>().getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: _moviesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Column(children: [
              LinearProgressIndicator(),
              shimmerListItem,
              shimmerListItem,
              shimmerListItem,
            ]);
          default:
            return ListView(
              children: snapshot.data.map((Movie movie) {
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.director),
                );
              }).toList(),
            );
        }
      },
    );
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
