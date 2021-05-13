import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plibrary/database_service/models/book.dart';
import 'package:plibrary/database_service/models/game.dart';
import 'package:plibrary/database_service/models/library_item.dart';
import 'package:plibrary/database_service/models/series.dart';

import 'models/movie.dart';

class DatabaseRepository {
  final AuthenticationRepository _authenticationRepository;
  final FirebaseFirestore _firestore;

  DatabaseRepository(this._authenticationRepository, this._firestore);

  Future generateLibraryDirectories() async {
    await _firestore
        .collection('users')
        .doc(_authenticationRepository.currentUser.id)
        .set({});
  }

  Future addNewItem(LibraryItem item) async {
    await _firestore
        .collection('users')
        .doc(_authenticationRepository.currentUser.id)
        .collection(item.collectionName)
        .doc(item.uuid)
        .set(item.toMap());
  }

  Future deleteItem(LibraryItem item) async {
    await _firestore
        .collection('users')
        .doc(_authenticationRepository.currentUser.id)
        .collection(item.collectionName)
        .doc(item.uuid)
        .delete();
  }

  
  Stream<List<Movie>> getMovies() {
    return _firestore
        .collection('users')
        .doc(_authenticationRepository.currentUser.id)
        .collection('movies')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((document) => Movie.fromMap(document.data()))
          .toList();
    });
  }

  Stream<List<Series>> getSeries() {
    return _firestore
        .collection('users')
        .doc(_authenticationRepository.currentUser.id)
        .collection('series')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((document) => Series.fromMap(document.data()))
          .toList();
    });
  }

  Stream<List<Book>> getBooks() {
    return _firestore
        .collection('users')
        .doc(_authenticationRepository.currentUser.id)
        .collection('books')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((document) => Book.fromMap(document.data()))
          .toList();
    });
  }

  Stream<List<Game>> getGames() {
    return _firestore
        .collection('users')
        .doc(_authenticationRepository.currentUser.id)
        .collection('games')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((document) => Game.fromMap(document.data()))
          .toList();
    });
  }
}
