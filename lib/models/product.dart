class Product {
  String? description;
  String? product;
  String? code;
  double? price;
  int? physicalQuantity;
  int? actualQuantity;

  Product({
    this.description,
    this.product,
    this.code,
    this.price,
    this.physicalQuantity,
    this.actualQuantity,
  });

  Product.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    product = json['product'];
    code = json['code'];
    price = json['price'].toDouble();
    physicalQuantity = json['physicalQuantity'];
    actualQuantity = json['actualQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['product'] = product;
    data['code'] = code;
    data['price'] = price;
    data['physicalQuantity'] = physicalQuantity;
    data['actualQuantity'] = actualQuantity;
    return data;
  }
}
