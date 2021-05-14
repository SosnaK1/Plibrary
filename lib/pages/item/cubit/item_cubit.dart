import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models.dart';
import 'package:plibrary/database_service/models/library_item.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit(this._databaseRepository, LibraryItem item)
      : super(ItemState(item: item));

  final DatabaseRepository _databaseRepository;

  void finishedChanged(bool value) {
    if (state.item is Movie) {
      emit(state.copyWith(
          item: (state.item as Movie).copyWith(finished: value),
          formModified: true));
      return;
    }

    if (state.item is Series) {
      emit(state.copyWith(
          item: (state.item as Series).copyWith(finished: value),
          formModified: true));
      return;
    }

    if (state.item is Book) {
      emit(state.copyWith(
          item: (state.item as Book).copyWith(finished: value),
          formModified: true));
      return;
    }

    if (state.item is Game) {
      emit(state.copyWith(
          item: (state.item as Game).copyWith(finished: value),
          formModified: true));
      return;
    }
  }

  void scoreChanged(double newValue) {
    if (state.item is Movie) {
      emit(state.copyWith(
          item: (state.item as Movie).copyWith(score: newValue),
          formModified: true));
      return;
    }

    if (state.item is Series) {
      emit(state.copyWith(
          item: (state.item as Series).copyWith(score: newValue),
          formModified: true));
      return;
    }

    if (state.item is Book) {
      emit(state.copyWith(
          item: (state.item as Book).copyWith(score: newValue),
          formModified: true));
      return;
    }

    if (state.item is Game) {
      emit(state.copyWith(
          item: (state.item as Game).copyWith(score: newValue),
          formModified: true));
      return;
    }
  }

  void saveChanges() async {
    // TODO: Show error toast
    if (state.item.title.isEmpty) return;

    print(state.item.uuid);

    await _databaseRepository.addNewItem(state.item);
  }
}
