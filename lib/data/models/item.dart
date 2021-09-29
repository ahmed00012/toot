class Item {
  Item({
    this.id,
    this.name,
    this.image,
    this.price,
    this.inFavourite,
  });

  int? id;
  String? name;
  String? image;
  String? price;
  int? inFavourite;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        inFavourite: json["in_favourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "in_favourite": inFavourite,
      };
}
