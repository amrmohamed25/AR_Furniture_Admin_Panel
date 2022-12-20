import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/models/furniture_model.dart';
import 'package:ar_furniture_admin_panel/models/shared_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/order_model.dart';
import '../screens/add_furniture_screen.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(InitialAdminState());

  List<Map<String, dynamic>> categories = [];
  List<OrderModel> orders = [];
  List<FurnitureModel> furnitureList = [];
  List<String> returnedCategory = [];
  Map<String, dynamic> lastDocMap = {};
  Map<String, bool> moreFurnitureCategory = {};
  String lastSearchbarName = "";
  String lastCategorySearch = "";
  bool moreFurnitureAvailable = true;
  DocumentSnapshot? _lastDocumentSearch;

  getAllData() async {
    emit(LoadingAllData());
    await getCategories();
    for (int i = 0; i < categories.length; i++) {
      print("testtttttttttttttt");
      print(categories[i]["name"]);

      await getFurniture(categories[i]["name"], limit: 6);
    }
    // await getOrders();
    emit(LoadedAllData());
  }

  getCategories() async {
    print("sad");
    await FirebaseFirestore.instance
        .collection("names")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.data());
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        for (var i in data["names"]) {
          // print(i["name"]);
          categories.add(i);
        }
      });
    });
    emit(GetAllCategoriesState());
  }

  addFurniture(context,
      {required String furnitureName,
      required FileOrURL model,
      required String furnitureCategory,
      required String furnitureDescription,
      required List<SharedProperties> myShared}) async {
    emit(UploadingFurnitureInProgressState());
    bool doesExistInFirestore = false;
    await FirebaseFirestore.instance
        .collection("category")
        .doc(furnitureCategory)
        .collection("furniture")
        .where("name", isEqualTo: furnitureName)
        .get()
        .catchError((error) {
      emit(UploadingFurnitureErrorState());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$furnitureName already exists")));
      doesExistInFirestore = true;
    });
    if (doesExistInFirestore == true) {
      return;
    }
    // String modelLink="";
    var doc = FirebaseFirestore.instance
        .collection("category")
        .doc(furnitureCategory)
        .collection("furniture")
        .doc()
        .id;
    if (model.file != null) {
      await FirebaseStorage.instance
          .ref(
              'furniture/${furnitureCategory}/${doc}_${model.urlController.text}')
          .putData(model.file!)
          .then((p0) async {
        String url = await p0.ref.getDownloadURL();
        model.urlController.text = url;
        print(url);
      });
    }
    print(doc);
    List<SharedModel> shared = [];
    for (int i = 0; i < myShared.length; i++) {
      print(myShared[i].image.urlController.text);
      if (myShared[i].image.file != null) {
        await FirebaseStorage.instance
            .ref(
                'furniture/${furnitureCategory}/${doc}_${myShared[i].image.urlController.text}')
            .putData(myShared[i].image.file!)
            .then((p0) async {
          String url = await p0.ref.getDownloadURL();
          myShared[i].image.urlController.text = url;
        });
      }
      shared.add(SharedModel(
          color: myShared[i].color.text,
          colorName: myShared[i].colorName.text,
          image: myShared[i].image.urlController.text,
          price: myShared[i].price.text,
          quantity: myShared[i].quantity.text,
          discount: myShared[i].discount.text));
    }

    FurnitureModel furnitureModel = FurnitureModel(
        description: furnitureDescription,
        furnitureId: doc,
        name: furnitureName,
        model: model.urlController.text,
        category: furnitureCategory,
        shared: shared,
        ratings: {});
    print(furnitureModel.shared.first.image);

    await FirebaseFirestore.instance
        .collection("category")
        .doc(furnitureCategory)
        .collection("furniture")
        .doc(doc)
        .set(furnitureModel.toMap());
    print("Done");
    furnitureList.add(furnitureModel);
    emit(UploadingFurnitureSuccessState());

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$furnitureName added successfully")));
  }

  getOrders() async {
    emit(LoadingOrderState());
    await FirebaseFirestore.instance.collection("order").get().then((value) {
      value.docs.forEach((element) {
        orders.add(OrderModel.fromJson(element.data()));
      });
      emit(LoadedOrderState());
    });
  }

  getFurniture(String categoryName, {limit = 0}) async {
    emit(LoadingFurnitureState());
    if (!moreFurnitureCategory.containsKey(categoryName)) {
      moreFurnitureCategory[categoryName] = true;
    }
    if (!returnedCategory.contains(categoryName)) {
      returnedCategory.add(categoryName);
    }

    int flag = 0;
    int sizeFurnitureBefore = furnitureList.length;

    if (limit == 0) {
      await FirebaseFirestore.instance
          .collection('category')
          .doc(categoryName)
          .collection('furniture')
          .get()
          .then((value) {
        for (var element in value.docs) {
          FurnitureModel myFurniture = FurnitureModel.fromJson(element.data());
          flag = 0;
          furnitureList.forEach((element) {
            if (element.furnitureId == myFurniture.furnitureId) {
              flag = 1;
            }
          });
          if (flag == 0) {
            furnitureList.add(myFurniture);
          }
        }
      });
      if (moreFurnitureCategory.containsKey(categoryName)) {
        moreFurnitureCategory.update(categoryName, (value) => false);
      } else {
        moreFurnitureCategory[categoryName] = false;
      }
    } else {
      if (lastDocMap.keys.contains(categoryName)) {
        await FirebaseFirestore.instance
            .collection('category')
            .doc(categoryName)
            .collection("furniture")
            .orderBy('furnitureId')
            .startAfter([lastDocMap[categoryName].get('furnitureId')])
            .limit(limit)
            .get()
            .then((snapshot) {
              print("3ndooooo");
              print(snapshot.docs.length);
              if (snapshot.docs.length < limit) {
                moreFurnitureCategory.update(categoryName, (value) => false);
              }
              if (snapshot.docs.length > 0) {
                lastDocMap[categoryName] = snapshot.docs.last;
                print("object test" + lastDocMap[categoryName].toString());
                snapshot.docs.forEach((snap) {
                  print("Snap" + lastDocMap[categoryName].get('furnitureId'));
                  FurnitureModel myFurniture =
                  FurnitureModel.fromJson(snap.data());
                  flag = 0;
                  furnitureList.forEach((element) {
                    if (element.furnitureId == myFurniture.furnitureId) {
                      flag = 1;
                    }
                  });
                  if (flag == 0) {
                    furnitureList.add(myFurniture);
                  }
                });
              }
            })
            .catchError((error) => print("Error: " + error.toString()));
      } else {
        print(categoryName);
        await FirebaseFirestore.instance
            .collection('category')
            .doc(categoryName)
            .collection("furniture")
            .orderBy('furnitureId')
            .limit(limit)
            .get()
            .then((snapshot) {
          if (snapshot.docs.length < limit) {
            moreFurnitureCategory.update(categoryName, (value) => false);
          }
          if (snapshot.docs.length > 0) {
            lastDocMap[categoryName] = snapshot.docs.last;
            snapshot.docs.forEach((snap) {
              FurnitureModel myFurniture = FurnitureModel.fromJson(snap.data());
              flag = 0;
              furnitureList.forEach((element) {
                if (element.furnitureId == myFurniture.furnitureId) {
                  flag = 1;
                }
              });
              if (flag == 0) {
                furnitureList.add(myFurniture);
              }
            });
          }
        }).catchError((error) => print("Error: " + error.toString()));
      }
    }

    emit(LoadedFurnitureState());
    print(furnitureList.length);
    if (sizeFurnitureBefore == furnitureList.length) {
      moreFurnitureCategory.update(categoryName, (value) => false);
    }
  }

  getSearchData(String categoryName,String searchbarName) async {
    print("ANA GET SEARCH DATA   $searchbarName");
    int sizeFurniture = furnitureList.length;
    lastSearchbarName = searchbarName;
    lastCategorySearch = categoryName;
    moreFurnitureAvailable = true;
    int flag = 0;
    await FirebaseFirestore.instance
        .collection('category')
        .doc(categoryName)
        .collection("furniture")
        .where('name',
        isGreaterThanOrEqualTo: searchbarName,
        isLessThanOrEqualTo: '$searchbarName\uf8ff')
        .orderBy('name')
        .limit(6)
        .get()
        .then((snapshot) {
      if(snapshot.docs.length < 6) {
        moreFurnitureAvailable = false;
      }
      if (snapshot.docs.length != 0) {
        _lastDocumentSearch = snapshot.docs.last;
        snapshot.docs.forEach((snap) {
          FurnitureModel myFurniture = FurnitureModel.fromJson(snap.data());
          flag = 0;
          furnitureList.forEach((element) {
            if (element.furnitureId == myFurniture.furnitureId) {
              flag = 1;
            }
          });
          if (flag == 0) {
            furnitureList.add(myFurniture);
          }
        });
      }
    }).catchError((error) => print("Error: " + error.toString()));
    print("ANA 5LAST GET SEARCH DATA   $searchbarName");
    if (sizeFurniture == furnitureList.length) {
      moreFurnitureAvailable = false;
    }
  }

  getMoreSearchData (String categoryName, String searchbarName) async {
    print("ANA GET MORE DATAAAAAAA  $searchbarName");
    print(moreFurnitureAvailable);
    if (moreFurnitureAvailable == false) {
      return;
    }
    int flag = 0;
    int sizeFurniture = furnitureList.length;
    await FirebaseFirestore.instance
        .collection('category')
        .doc(categoryName)
        .collection("furniture")
        .where('name',
        isGreaterThanOrEqualTo: searchbarName,
        isLessThanOrEqualTo: '$searchbarName\uf8ff')
        .orderBy('name')
        .startAfter([_lastDocumentSearch?.data()])
        .limit(6)
        .get()
        .then((snapshot) {
      if(snapshot.docs.length < 6) {
        moreFurnitureAvailable = false;
      }
      if (snapshot.docs.length != 0) {
        _lastDocumentSearch = snapshot.docs.last;
        snapshot.docs.forEach((snap) {
          FurnitureModel myFurniture = FurnitureModel.fromJson(snap.data());
          flag = 0;
          furnitureList.forEach((element) {
            if (element.furnitureId == myFurniture.furnitureId) {
              flag = 1;
            }
          });
          if (flag == 0) {
            furnitureList.add(myFurniture);
          }
        });
      }
    }).catchError((error) => print("Error: " + error.toString()));
    print("ANA 5LAST GET MORE DATAAAAAAA  $searchbarName");
    if (sizeFurniture == furnitureList.length) {
      moreFurnitureAvailable = false;
    }
  }

}
