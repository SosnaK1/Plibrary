part of 'books_cubit.dart';

class BooksState extends Equatable {
  const BooksState({this.booksStream, this.searchFilter = ""});

  final Stream<List<Book>> booksStream;
  final String searchFilter;

  @override
  List<Object> get props => [booksStream, searchFilter];

  BooksState copyWith(
      {Stream<List<Book>> booksStream, String searchFilter}) {
    return BooksState(
        booksStream: booksStream ?? this.booksStream,
        searchFilter: searchFilter ?? this.searchFilter);
  }
}
