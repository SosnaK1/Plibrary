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

  final String uuid;
  final String title;
  final String author;
  final BookGenre genre;
  final String description;
  final bool finished;
  final double score;

  const Book(
      {this.uuid,
      this.title,
      this.author,
      this.genre,
      this.description,
      this.finished,
      this.score});

  Book.fromMap(Map<String, dynamic> data)
      : this(
            uuid: data['uuid'],
            title: data['title'],
            author: data['author'],
            genre: bookGenreFromString(data['genre']),
            description: data['description'],
            finished: data['finished'],
            score: data['score']);

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'title': title,
      'author': author,
      'genre': genre.toShortString(),
      'description': description,
      'finished': finished,
      'score': score
    };
  }
}
