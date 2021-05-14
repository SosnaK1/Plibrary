abstract class LibraryItem {
  final String collectionName;
  final String itemName;
  final String uuid;
  final String title;
  final bool finished;
  final double score;

  LibraryItem(
      this.collectionName, this.itemName, this.uuid, this.title, this.finished, this.score);

  Map<String, dynamic> toMap();
}
