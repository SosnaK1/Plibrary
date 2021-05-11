// enum MovieGenre {
//   Action,
//   Adventure,
//   Animation,
//   Biography,
//   Comedy,
//   Crime,
//   Documentary,
//   Drama,
//   Family,
//   Fantasy,
//   Film_Noir,
//   History,
//   Horror,
//   Music,
//   Musical,
//   Mystery,
//   Romance,
//   SciFi,
//   Short_Film,
//   Sport,
//   Superhero,
//   Thriller,
//   War,
//   Western
// }

// extension ParseToString on MovieGenre {
//   String toShortString() {
//     return this.toString().split('.').last;
//   }
// }

// T enumFromString<T>(Iterable<T> values, String value) {
//   return values.firstWhere((type) => type.toString().split(".").last == value,
//       orElse: () => null);
// }

class Movie {
  final String uuid;
  final String title;
  final String director;
  final String image;
  final double score;

  const Movie({this.uuid, this.title, this.director, this.image, this.score});

  Movie.fromMap(Map<String, dynamic> data)
      : this(
            uuid: data['uuid'],
            title: data['title'],
            director: data['director'],
            image: data['image'],
            score: data['score']);

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'title': title,
      'director': director,
      'image': image,
      'score': score
    };
  }
}
