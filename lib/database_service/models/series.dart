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
  final String itemName = "series";

  final String uuid;
  final String title;
  final String director;
  final SeriesGenre genre;
  final String description;
  final bool finished;
  final double score;
  final DateTime timeAdded;

  const Series(
      {this.uuid,
      this.title,
      this.director,
      this.genre,
      this.description,
      this.finished,
      this.score,
      this.timeAdded});

  Series.fromMap(Map<String, dynamic> data)
      : this(
            uuid: data['uuid'],
            title: data['title'],
            director: data['director'],
            genre: seriesGenreFromString(data['genre']),
            description: data['description'],
            finished: data['finished'],
            score: data['score'],
            timeAdded: DateTime.parse(data['time_added']));

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'title': title,
      'director': director,
      'genre': genre.toShortString(),
      'description': description,
      'finished': finished,
      'score': score,
      'time_added': timeAdded.toString()
    };
  }

  Series copyWith(
      {String title,
      String director,
      String description,
      SeriesGenre genre,
      bool finished,
      double score,
      DateTime timeAdded}) {
    return Series(
        uuid: this.uuid,
        title: title ?? this.title,
        director: director ?? this.director,
        description: description ?? this.description,
        genre: genre ?? this.genre,
        finished: finished ?? this.finished,
        score: score ?? this.score,
        timeAdded: timeAdded ?? this.timeAdded);
  }
}
