class SharedModel {
  late String color;
  late String colorName;
  late String image;
  late String model;
  late String price;
  late String quantity;
  late String discount;
  String quantityCart='0';

  SharedModel(
      {
        required this.model,
        required this.color,
        required this.colorName,
        required this.image,
        required this.price,
        required this.quantity,
        required this.discount
      });

  SharedModel.fromJson(Map<String, dynamic> json) {
    color = json["color"];
    colorName = json["colorName"];
    image = json["image"];
    price = json["price"];
    quantity = json["quantity"];
    discount = json["discount"];
    model=json["model"];
  }
  Map<String, dynamic> toMap() {
    print("Inside Shared Model");
    print(quantityCart);
    return {
      "color": color,
      "colorName": colorName,
      "image": image,
      "price": price,
      "quantity": quantity,
      "discount": discount
      ,"model":model
    };
  }
}
