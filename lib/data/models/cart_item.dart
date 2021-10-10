class CartItem {
  CartItem({
    this.data,
  });

  Data? data;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.subTotal,
    this.discount,
    this.tax,
    this.total,
    this.quantity,
    this.deliveryFee,
    this.pointsToCash,
    this.items,
  });

  int? id;
  double? subTotal;
  dynamic discount;
  double? tax;
  double? total;
  int? quantity;
  String? deliveryFee;
  int? pointsToCash;
  List<CartItemDetails>? items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        subTotal: json["sub_total"].toDouble(),
        discount: json["discount"],
        tax: json["tax"].toDouble(),
        total: json["total"].toDouble(),
        quantity: json["quantity"],
        deliveryFee: json["delivery_fee"],
        pointsToCash: json["points_to_cash"],
        items: List<CartItemDetails>.from(
            json["items"].map((x) => CartItemDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_total": subTotal,
        "discount": discount,
        "tax": tax,
        "total": total,
        "quantity": quantity,
        "delivery_fee": deliveryFee,
        "points_to_cash": pointsToCash,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class CartItemDetails {
  CartItemDetails({
    this.id,
    this.cartId,
    this.productId,
    this.hasGiftCard,
    this.hasPersonalName,
    this.subTotal,
    this.total,
    this.count,
    this.weightId,
    this.createdAt,
    this.updatedAt,
    this.note,
    this.price,
    this.productName,
    this.productImage,
    this.weight,
    this.cartitemaddon,
    this.cartitemoption,
  });

  int? id;
  int? cartId;
  int? productId;
  int? hasGiftCard;
  int? hasPersonalName;
  double? subTotal;
  double? total;
  int? count;
  dynamic weightId;
  String? createdAt;
  String? updatedAt;
  dynamic note;
  String? price;
  String? productName;
  String? productImage;
  dynamic weight;
  List<dynamic>? cartitemaddon;
  List<dynamic>? cartitemoption;

  factory CartItemDetails.fromJson(Map<String, dynamic> json) =>
      CartItemDetails(
        id: json["id"],
        cartId: json["cart_id"],
        productId: json["product_id"],
        hasGiftCard: json["has_gift_card"],
        hasPersonalName: json["has_personal_name"],
        subTotal: json["sub_total"].toDouble(),
        total: json["total"].toDouble(),
        count: json["count"],
        weightId: json["weight_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        note: json["note"],
        price: json["price"],
        productName: json["product_name"],
        productImage: json["product_image"],
        weight: json["weight"],
        cartitemaddon: List<dynamic>.from(json["cartitemaddon"].map((x) => x)),
        cartitemoption:
            List<dynamic>.from(json["cartitemoption"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "product_id": productId,
        "has_gift_card": hasGiftCard,
        "has_personal_name": hasPersonalName,
        "sub_total": subTotal,
        "total": total,
        "count": count,
        "weight_id": weightId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "note": note,
        "price": price,
        "product_name": productName,
        "product_image": productImage,
        "weight": weight,
        "cartitemaddon": List<dynamic>.from(cartitemaddon!.map((x) => x)),
        "cartitemoption": List<dynamic>.from(cartitemoption!.map((x) => x)),
      };
}
