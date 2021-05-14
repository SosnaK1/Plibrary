abstract class LibraryItem {
  final String collectionName;
  final String itemName;
  final String uuid;

  LibraryItem(this.collectionName, this.itemName, this.uuid);

  Map<String, dynamic> toMap();
}
