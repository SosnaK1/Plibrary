import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models.dart';
import 'package:plibrary/database_service/models/library_item.dart';
import 'package:plibrary/widgets/text_input_dialog.dart';

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

  Future<void> saveChanges() async {
    // TODO: Show error toast
    if (state.item.title.isEmpty) return;

    await _databaseRepository.addNewItem(state.item);
    emit(state.copyWith(formModified: false));
  }

  void dialogTitleChanged(String value) {
    emit(state.copyWith(dialogTitle: value));
  }

  void dialogAuthorChanged(String value) {
    emit(state.copyWith(dialogAuthor: value));
  }

  void dialogGenreChanged(String value) {
    emit(state.copyWith(dialogGenre: value));
  }

  void dialogDescriptionChanged(String value) {
    emit(state.copyWith(dialogDescription: value));
  }

  void dialogConfirmedChange(EditableFieldType fieldType) {
    switch (fieldType) {
      case EditableFieldType.title:
        titleChanged(state.dialogTitle);
        break;
      case EditableFieldType.author:
        authorChanged(state.dialogAuthor);
        break;
      case EditableFieldType.genre:
        genreChanged(state.dialogGenre);
        break;
      case EditableFieldType.description:
        descriptionChanged(state.dialogDescription);
        break;
    }
  }

  void titleChanged(String value) {
    if (state.item is Movie) {
      emit(state.copyWith(
          item: (state.item as Movie).copyWith(title: value),
          formModified: true));
      return;
    }

    if (state.item is Series) {
      emit(state.copyWith(
          item: (state.item as Series).copyWith(title: value),
          formModified: true));
      return;
    }

    if (state.item is Book) {
      emit(state.copyWith(
          item: (state.item as Book).copyWith(title: value),
          formModified: true));
      return;
    }

    if (state.item is Game) {
      emit(state.copyWith(
          item: (state.item as Game).copyWith(title: value),
          formModified: true));
      return;
    }
  }

  void authorChanged(String value) {
    if (state.item is Movie) {
      emit(state.copyWith(
          item: (state.item as Movie).copyWith(director: value),
          formModified: true));
      return;
    }

    if (state.item is Series) {
      emit(state.copyWith(
          item: (state.item as Series).copyWith(director: value),
          formModified: true));
      return;
    }

    if (state.item is Book) {
      emit(state.copyWith(
          item: (state.item as Book).copyWith(author: value),
          formModified: true));
      return;
    }

    if (state.item is Game) {
      emit(state.copyWith(
          item: (state.item as Game).copyWith(studio: value),
          formModified: true));
      return;
    }
  }

  void descriptionChanged(String value) {
    if (state.item is Movie) {
      emit(state.copyWith(
          item: (state.item as Movie).copyWith(description: value),
          formModified: true));
      return;
    }

    if (state.item is Series) {
      emit(state.copyWith(
          item: (state.item as Series).copyWith(description: value),
          formModified: true));
      return;
    }

    if (state.item is Book) {
      emit(state.copyWith(
          item: (state.item as Book).copyWith(description: value),
          formModified: true));
      return;
    }

    if (state.item is Game) {
      emit(state.copyWith(
          item: (state.item as Game).copyWith(description: value),
          formModified: true));
      return;
    }
  }

  void genreChanged(String value) {
    if (state.item is Movie) {
      emit(state.copyWith(
          item: (state.item as Movie)
              .copyWith(genre: movieGenreFromString(value)),
          formModified: true));
      return;
    }

    if (state.item is Series) {
      emit(state.copyWith(
          item: (state.item as Series)
              .copyWith(genre: seriesGenreFromString(value)),
          formModified: true));
      return;
    }

    if (state.item is Book) {
      emit(state.copyWith(
          item:
              (state.item as Book).copyWith(genre: bookGenreFromString(value)),
          formModified: true));
      return;
    }

    if (state.item is Game) {
      emit(state.copyWith(
          item:
              (state.item as Game).copyWith(genre: gameGenreFromString(value)),
          formModified: true));
      return;
    }
  }
}
