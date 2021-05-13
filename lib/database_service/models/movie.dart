import 'package:plibrary/database_service/models/library_item.dart';

enum MovieGenre {
  Action,
  Adventure,
  Animation,
  Biography,
  Comedy,
  Crime,
  Documentary,
  Drama,
  Family,
  Fantasy,
  Film_Noir,
  History,
  Horror,
  Music,
  Musical,
  Mystery,
  Romance,
  SciFi,
  Short_Film,
  Sport,
  Superhero,
  Thriller,
  War,
  Western
}

extension ParseMovieToString on MovieGenre {
  String toShortString() {
    return this.toString().split('.').last.replaceAll("_", " ");
  }
}

MovieGenre movieGenreFromString(String value) {
  return MovieGenre.values.firstWhere(
      (type) => type.toString().split(".").last == value.replaceAll(" ", "_"),
      orElse: () => null);
}

class Movie implements LibraryItem {
  final String collectionName = "movies";

  final String uuid;
  final String title;
  final String director;
  final MovieGenre genre;
  final String description;
  final bool finished;
  final double score;

  const Movie(
      {this.uuid,
      this.title,
      this.director,
      this.genre,
      this.description,
      this.finished,
      this.score});

  Movie.fromMap(Map<String, dynamic> data)
      : this(
            uuid: data['uuid'],
            title: data['title'],
            director: data['director'],
            genre: movieGenreFromString(data['genre']),
            description: data['description'],
            finished: data['finished'],
            score: data['score']);

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'title': title,
      'director': director,
      'genre': genre.toShortString(),
      'description': description,
      'finished': finished,
      'score': score
    };
  }
}
