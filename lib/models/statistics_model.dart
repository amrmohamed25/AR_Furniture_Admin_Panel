class Statistics {
  late String income;
  late String ordersNumber;
  late String year;
  late String month;
  Map<String,dynamic> category = {};

  Statistics({
    required this.income,
    required this.ordersNumber,
    required this.year,
    required this.month,
    required this.category
  });

  Statistics.fromJson(Map<String, dynamic> json) {
    income = json["income"];
    ordersNumber = json["ordersNumber"];
    year = json["year"];
    month = json["month"];
    json["category"].forEach((key, value) {
      category[key] = CategoryStatistics.fromJson(value);
    });
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempCategoryMap = {};
    category.forEach((key, value) {
      tempCategoryMap[key] = value.toMap();
    });
    return {
      "income": income,
      "ordersNumber": ordersNumber,
      "year": year,
      "month": month,
      "category": tempCategoryMap
    };
  }
}

class CategoryStatistics {
  late String count;
  late String payment;

  CategoryStatistics({
    required this.count,
    required this.payment,
  });

  CategoryStatistics.fromJson(Map<String, dynamic> json) {
    count = json["count"];
    payment = json["payment"];
  }

  Map<String, dynamic> toMap() {
    return {
      "count": count,
      "payment": payment,
    };
  }
}