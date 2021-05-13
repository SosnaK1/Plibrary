import 'library_item.dart';

enum SeriesGenre {
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
  Game_Show,
  History,
  Horror,
  Music,
  Musical,
  Mystery,
  News,
  Reality_TV,
  Romance,
  SciFi,
  Sport,
  Superhero,
  Talk_Show,
  Thriller,
  War,
  Western
}

extension ParseSeriesToString on SeriesGenre {
  String toShortString() {
    return this.toString().split('.').last.replaceAll("_", " ");
  }
}

SeriesGenre seriesGenreFromString(String value) {
  return SeriesGenre.values.firstWhere(
      (type) => type.toString().split(".").last == value.replaceAll(" ", "_"),
      orElse: () => null);
}

class Series implements LibraryItem {
  final String collectionName = "series";

  final String uuid;
  final String title;
  final String director;
  final SeriesGenre genre;
  final String description;
  final bool finished;
  final double score;

  const Series(
      {this.uuid,
      this.title,
      this.director,
      this.genre,
      this.description,
      this.finished,
      this.score});

  Series.fromMap(Map<String, dynamic> data)
      : this(
            uuid: data['uuid'],
            title: data['title'],
            director: data['director'],
            genre: seriesGenreFromString(data['genre']),
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