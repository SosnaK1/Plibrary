import 'package:plibrary/database_service/models/library_item.dart';

enum BookGenre {
  Fantasy,
  Adventure,
  Romance,
  Contemporary,
  Dystopian,
  Mystery,
  Horror,
  Thriller,
  Paranormal,
  Historical_Fiction,
  Science_Fiction,
  Memoir,
  Cooking,
  Art,
  Self_Help,
  Development,
  Motivational,
  Health,
  History,
  Travel,
  Guide,
  Relationships,
  Humor,
  Childrens,
}

extension ParseBookToString on BookGenre {
  String toShortString() {
    return this.toString().split('.').last.replaceAll("_", " ");
  }
}

BookGenre bookGenreFromString(String value) {
  return BookGenre.values.firstWhere(
      (type) => type.toString().split(".").last == value.replaceAll(" ", "_"),
      orElse: () => null);
}

class Book implements LibraryItem {
  final String collectionName = "books";
  final String itemName = "book";

  final String uuid;
  final String title;
  final String author;
  final BookGenre genre;
  final String description;
  final bool finished;
  final double score;
  final DateTime timeAdded;

  const Book(
      {this.uuid,
      this.title,
      this.author,
      this.genre,
      this.description,
      this.finished,
      this.score,
      this.timeAdded});

  Book.fromMap(Map<String, dynamic> data)
      : this(
            uuid: data['uuid'],
            title: data['title'],
            author: data['author'],
            genre: bookGenreFromString(data['genre']),
            description: data['description'],
            finished: data['finished'],
            score: data['score'],
            timeAdded: DateTime.parse(data['time_added']));

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'title': title,
      'author': author,
      'genre': genre.toShortString(),
      'description': description,
      'finished': finished,
      'score': score,
      'time_added': timeAdded.toString()
    };
  }

  Book copyWith(
      {String title,
      String author,
      String description,
      BookGenre genre,
      bool finished,
      double score,
      DateTime timeAdded}) {
    return Book(
        uuid: this.uuid,
        title: title ?? this.title,
        author: author ?? this.author,
        description: description ?? this.description,
        genre: genre ?? this.genre,
        finished: finished ?? this.finished,
        score: score ?? this.score,
        timeAdded: timeAdded ?? this.timeAdded);
  }
}
