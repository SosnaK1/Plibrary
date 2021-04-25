enum Genre {
  thriller,
  horror,
  adventure,
}

class Movie {
  final String id;
  final Genre type;
  final String title;
  final String director;
  final String imageURL;
  final String score;

  const Movie(
      {this.id,
      this.type,
      this.title,
      this.director,
      this.imageURL,
      this.score});

  Movie.fromMap(Map<String, dynamic> data, String id)
      : this(
            id: id,
            type: Genre.values[0],
            title: data['title'],
            director: data['director'],
            imageURL: data['image'],
            score: data['score']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'title': title,
      'director': director,
      'imageURL': imageURL,
      'score': score
    };
  }
}
