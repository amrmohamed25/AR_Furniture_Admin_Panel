
import 'package:ar_furniture_admin_panel/models/shared_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  late String orderId;
  late String uid;
  late String userName;
  late Timestamp time;
  late String appartmentNumber;
  late String area;
  late String buildingNumber;
  late String floorNumber;
  late String mobileNumber;
  late String streetName;
  Map<String,dynamic> order={};


  // List<SharedModel> shared = [];
  // bool isFavorite=false;
  // List<double> ratings = [];

  OrderModel({
    required this.orderId,
    required this.uid,
    required this.userName,
    required this.time,
    required this.appartmentNumber,
    required this.area,
    required this.buildingNumber,
    required this.floorNumber,
    required this.mobileNumber,
    required this.streetName,
    required this.order,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json["orderId"];
    uid = json["uid"];
    userName = json["userName"];
    time = json["time"];
    appartmentNumber = json["appartmentNumber"];
    area = json["area"];
    buildingNumber = json["buildingNumber"];
    floorNumber = json["floorNumber"];
    mobileNumber = json["mobileNumber"];
    streetName = json["streetName"];

    json["order"].forEach((key, value) {
      List<SharedModel> shared = [];
      value.forEach((element) {
        SharedModel tempShared = SharedModel.fromJson(element);
        tempShared.quantityCart = element['quantityCart'];
        shared.add(tempShared);
      });
      order[key] = shared;
    });
  }

    Map<String, dynamic> toMap() {
      Map<String, dynamic> tempCartMap = {};
      List<Map<String, dynamic>> tempSharedList = [];
      order.forEach((key, value) {
        tempSharedList = [];
        value.forEach((element) {
          Map<String, dynamic> tempSharedMap = element.toMap();
          tempSharedMap['quantityCart'] = element.quantityCart;
          tempSharedList.add(tempSharedMap);
        });
        tempCartMap[key] = tempSharedList;
      });
      return {
        "orderId": orderId,
        "uid": uid,
        "userName": userName,
        "time": time,
        "appartmentNumber": appartmentNumber,
        "area": area,
        "buildingNumber": buildingNumber,
        "floorNumber": floorNumber,
        "mobileNumber": mobileNumber,
        "streetName": streetName,
        "order": tempCartMap
      };
    }
  }


