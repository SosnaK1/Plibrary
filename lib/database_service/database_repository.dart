import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    // await usersCollection.doc(uid).collection("movies").doc("1").set({});
    // await usersCollection.doc(uid).collection("movies").doc("1").delete();
    // await usersCollection.doc(uid).collection("series").doc("1").set({});
    // await usersCollection.doc(uid).collection("series").doc("1").delete();
    // await usersCollection.doc(uid).collection("books").doc("1").set({});
    // await usersCollection.doc(uid).collection("books").doc("1").delete();
    // await usersCollection.doc(uid).collection("games").doc("1").set({});
    // await usersCollection.doc(uid).collection("games").doc("1").delete();
  }

  Future addNewMovie(Movie movie) async {
    await _firestore
        .collection('users')
        .doc(_authenticationRepository.currentUser.id)
        .collection('movies')
        .doc(movie.id)
        .set(movie.toMap());
  }

  // Future addNewSeries(String uid, Series series) async {

  // }

  // Future addNewBook(String uid, Book book) async {

  // }

  // Future addNewGame(String uid, Game game) async {

  // }

  Stream<List<Movie>> getMovies() {
    return _firestore
        .collection('users')
        .doc(_authenticationRepository.currentUser.id)
        .collection('movies')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((document) => Movie.fromMap(document.data(), "1"))
          .toList();
    });
  }
}
