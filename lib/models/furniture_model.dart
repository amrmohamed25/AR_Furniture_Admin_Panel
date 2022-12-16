
import 'package:ar_furniture_admin_panel/models/shared_model.dart';


class FurnitureModel {
  String? description;
  late String furnitureId;
  late String name;
  late String model;
  late String category;
  List<SharedModel> shared = [];
  bool isFavorite = false;
  Map<String, dynamic> ratings = {};

  FurnitureModel({
    this.description,
    required this.furnitureId,
    required this.name,
    required this.model,
    required this.category,
    required this.shared,
    required this.ratings,
  });

  FurnitureModel.fromJson(Map<String, dynamic> json) {
    description = json["description"];
    furnitureId = json["furnitureId"];
    name = json["name"];
    model = json["model"];
    category = json["category"];
    print("before");
    print(shared);
    for (int i = 0; i < json["shared"].length; i++) {
      shared.add(SharedModel.fromJson(json["shared"][i]));
    }
    print("after");
    print(shared);

    ratings = json["ratings"];
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> temp = [];
    for (int i = 0; i < shared.length; i++) {
      temp.add(shared[i].toMap());
    }
    return {
      "category": category,
      "description": description,
      "furnitureId": furnitureId,
      "name": name,
      "model": model,
      "shared": temp,
      "ratings": ratings,
    };
  }

  double calculateAverageRating() {
    double sum = 0;
    print("Ratings");
    print(ratings);
    for (double rating in ratings.values) {
      sum += rating;
    }
    double averageRating = sum / ratings.length;
    print(sum);
    print(ratings.length);
    print(averageRating);
    return double.parse(averageRating.toStringAsFixed(0));
  }
}
