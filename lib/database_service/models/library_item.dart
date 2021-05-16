abstract class LibraryItem {
  final String collectionName;
  final String itemName;
  final String uuid;
  final String title;
  final String description;
  final bool finished;
  final double score;
  final DateTime timeAdded;

  LibraryItem(this.collectionName, this.itemName, this.uuid, this.title,
      this.description, this.finished, this.score, this.timeAdded);

  Map<String, dynamic> toMap();
}
