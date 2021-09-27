class Category {
  Category({
    this.categoryName,
    this.markets,
  });

  String? categoryName;
  List<Market>? markets;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName: json["category_name"],
        markets:
            List<Market>.from(json["markets"].map((x) => Market.fromJson(x))),
      );
}

class Market {
  Market({
    this.id,
    this.image,
    this.name,
  });

  int? id;
  String? image;
  String? name;

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        id: json["id"],
        image: json["image"] == null ? null : json["image"],
        name: json["name"],
      );
}
