import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/book.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit(this._databaseRepository)
      : super(BooksState(booksStream: _databaseRepository.getBooks()));

  final DatabaseRepository _databaseRepository;

  void deleteBookFromDB(Book book) async {
    _databaseRepository.deleteItem(book);
  }

  void searchFilterChanged(String value) {
    emit(state.copyWith(searchFilter: value));
  }
}
