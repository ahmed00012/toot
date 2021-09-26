class Category {
  Category({
    required this.categoryName,
    required this.markets,
  });

  final String categoryName;
  final List<Market> markets;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName: json["category_name"],
        markets:
            List<Market>.from(json["markets"].map((x) => Market.fromJson(x))),
      );
}

class Market {
  Market({
    required this.id,
    required this.phone,
    required this.email,
    required this.deliveryFee,
    required this.isActive,
    required this.cityId,
    required this.regionId,
    required this.image,
    required this.vendorRate,
    required this.tasteRate,
    required this.priceRate,
    required this.deviceId,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.chatUid,
    required this.lat,
    required this.long,
    required this.maincategoryId,
    required this.userType,
    required this.uid,
    required this.name,
    required this.description,
  });

  final int id;
  final String phone;
  final String email;
  final int deliveryFee;
  final int isActive;
  final int cityId;
  final int regionId;
  final String image;
  final String vendorRate;
  final String tasteRate;
  final String priceRate;
  final dynamic deviceId;
  final dynamic emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String chatUid;
  final String lat;
  final String long;
  final int maincategoryId;
  final String userType;
  final String uid;
  final String name;
  final String description;

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        deliveryFee: json["delivery_fee"],
        isActive: json["is_active"],
        cityId: json["city_id"],
        regionId: json["region_id"],
        image: json["image"] == null ? null : json["image"],
        vendorRate: json["vendor_rate"],
        tasteRate: json["taste_rate"],
        priceRate: json["price_rate"],
        deviceId: json["device_id"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        chatUid: json["chat_uid"],
        lat: json["lat"] == null ? null : json["lat"],
        long: json["long"] == null ? null : json["long"],
        maincategoryId: json["maincategory_id"],
        userType: json["user_type"],
        uid: json["uid"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
      );
}
