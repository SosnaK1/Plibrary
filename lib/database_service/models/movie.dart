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
  final String title;
  final String director;
  final String imageURL;
  final double score;

  const Movie(
      {this.title, this.director, this.imageURL, this.score});

  Movie.fromMap(Map<String, dynamic> data)
      : this(
            title: data['title'],
            director: data['director'],
            imageURL: data['image'],
            score: data['score']);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'director': director,
      'imageURL': imageURL,
      'score': score
    };
  }
}
