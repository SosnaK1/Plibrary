abstract class LibraryItem {
  final String collectionName;
  final String uuid;

  LibraryItem(this.uuid, this.collectionName);

  Map<String, dynamic> toMap();
}
