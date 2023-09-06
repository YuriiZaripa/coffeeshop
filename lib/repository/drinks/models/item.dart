class Item {

  final int id;
  final String name;
  final String itemType;
  final double price;
  final String image;

  Item(this.id, this.name, this.itemType, this.price, this.image);

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      json['id'] as int,
      json['name'] as String,
      json['itemType'] as String,
      json['price'] as double,
      json['image'] as String,
    );
  }
}