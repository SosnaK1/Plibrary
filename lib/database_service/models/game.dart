import 'package:plibrary/database_service/models/library_item.dart';

enum GameGenre {
  Sandbox,
  Real_Time_Strategy,
  Shooters,
  Multiplayer_Online_Battle_Arena,
  Role_Playing,
  Simulation_and_Sports,
  Puzzlers_and_Party_Games,
  Action_Adventure,
  Survival_and_Horror,
  Platformer
}

extension ParseGameToString on GameGenre {
  String toShortString() {
    return this.toString().split('.').last.replaceAll("_", " ");
  }
}

GameGenre gameGenreFromString(String value) {
  return GameGenre.values.firstWhere(
      (type) => type.toString().split(".").last == value.replaceAll(" ", "_"),
      orElse: () => null);
}

class Game implements LibraryItem {
  final String collectionName = "games";
  final String itemName = "game";

  final String uuid;
  final String title;
  final String studio;
  final GameGenre genre;
  final String description;
  final bool finished;
  final double score;

  const Game(
      {this.uuid,
      this.title,
      this.studio,
      this.genre,
      this.description,
      this.finished,
      this.score});

  Game.fromMap(Map<String, dynamic> data)
      : this(
            uuid: data['uuid'],
            title: data['title'],
            studio: data['studio'],
            genre: gameGenreFromString(data['genre']),
            description: data['description'],
            finished: data['finished'],
            score: data['score']);

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'title': title,
      'studio': studio,
      'genre': genre.toShortString(),
      'description': description,
      'finished': finished,
      'score': score
    };
  }

  Game copyWith({
    String title,
    String studio,
    String description,
    GameGenre genre,
    bool finished,
    double score
  }) {
    return Game(
      uuid: this.uuid,
      title: title ?? this.title,
      studio: studio ?? this.studio,
      description: description ?? this.description,
      genre: genre ?? this.genre,
      finished: finished ?? this.finished,
      score: score ?? this.score,
    );
  }
}