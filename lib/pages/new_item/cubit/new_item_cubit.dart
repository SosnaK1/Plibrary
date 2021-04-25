import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/movie.dart';

part 'new_item_state.dart';

class NewItemCubit extends Cubit<NewItemState> {
  NewItemCubit(this._databaseRepository) : super(NewItemInitial());

  final DatabaseRepository _databaseRepository;

  Future<void> newItemSubmitted() async {
    Movie movie = Movie(
        id: "2",
        type: Genre.thriller,
        title: "Orphan 2",
        director: "Deniro",
        imageURL: null,
        score: "4");

    await _databaseRepository.addNewMovie(movie);


    //var movies = await _databaseRepository.getMovies().toList();
    //print(movies);
  }
}
