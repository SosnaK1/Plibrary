import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/movie.dart';
import 'package:plibrary/forms/models/models.dart';

part 'new_item_state.dart';

class NewItemCubit extends Cubit<NewItemState> {
  NewItemCubit(this._databaseRepository) : super(const NewItemState());

  final DatabaseRepository _databaseRepository;

  void selectedItemTypeChanged(String value) {
    emit(state.copyWith(selectedItemType: value));
  }

  void titleChanged(String value) {
    emit(state.copyWith(title: Title.dirty(value)));
  }

  Future<void> newItemSubmitted() async {
    Movie movie = Movie(
        id: "2",
        type: Genre.thriller,
        title: "Orphan 2",
        director: "Deniro",
        imageURL: null,
        score: "4");

    await _databaseRepository.addNewMovie(movie);
  }
}
