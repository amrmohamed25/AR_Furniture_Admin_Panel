import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/models/furniture_model.dart';
import 'package:ar_furniture_admin_panel/models/shared_model.dart';
import 'package:ar_furniture_admin_panel/screens/landingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/statistics_model.dart';
import '../models/order_model.dart';
import '../screens/add_furniture_screen.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(InitialAdminState());

  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> offers = [];
  List<OrderModel> orders = [];
  List<FurnitureModel> furnitureList = [];
  List<String> returnedCategory = [];
  Map<String, dynamic> lastDocMap = {};
  List<Color?> availableColors = [];
  Map<String, bool> moreFurnitureCategory = {};
  String lastSearchbarName = "";
  String lastCategorySearch = "";
  bool moreFurnitureAvailable = true;
  DocumentSnapshot? _lastDocumentSearch;
  DocumentSnapshot? lastDocumentOrderId ;
  bool moreOrdersAvailable = true;
  //Statistics
  Map<String, List<Statistics>> statisticsData = {};
  Map<String, dynamic> monthlyOrders = {
    "Jan": 0,
    "Feb": 0,
    "Mar": 0,
    "Apr": 0,
    "May": 0,
    "Jun": 0,
    "Jul": 0,
    "Aug": 0,
    "Sep": 0,
    "Oct": 0,
    "Nov": 0,
    "Dec": 0
  };
  List<String> years=[];
  List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  Map<String, dynamic> categoriesIncome = {};
  Map<String, dynamic> categoriesOrders = {};
  double totalIncome = 0;
  double totalOrders = 0;
  double maxMonthlyOrders = 0;
  double maxIncome = 0;

  getAllData() async {
    emit(LoadingAllData());
    await getCategories();

    for (int i = 0; i < categories.length; i++) {
      print("testtttttttttttttt");
      print(categories[i]["name"]);

      await getFurniture(categories[i]["name"], limit: 6);
    }
    await getYearsList();
    ///////// await getOrders();
    emit(LoadedAllData());
    await getStatisticsByYear(years.last);
  }

  getCategories() async {
    // print("sad");
    await FirebaseFirestore.instance
        .collection("names")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print(doc.data());
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
            'furniture/${furnitureCategory}/${doc}_${myShared[i].image
                .urlController.text}')
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

  addCategory(context, {required String categoryName, required FileOrURL categoryImage}) async {
    emit(AddingCategory());
    for (int i = 0; i < categories.length; i++) {
      if (categories[i]["name"] == categoryName) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$categoryName already exists")));
        return;
      }
    }

    // get id
    var documentId;
    await FirebaseFirestore.instance.collection("names").get().then((value) => documentId = value.docs.first.id);

    // add to categories
    Map<String, dynamic> newCategory = {};

    if (categoryImage.file != null) {
      await FirebaseStorage.instance.ref(
          'category_icons/${categoryImage.urlController.text}')
          .putData(categoryImage.file!)
          .then((p0) async {
        String url = await p0.ref.getDownloadURL();
        categoryImage.urlController.text = url;
      });
    }
    newCategory["image"] = categoryImage.urlController.text;
    newCategory["name"] = categoryName;
    categories.add(newCategory);

    // add category to firebase
    await FirebaseFirestore.instance.collection("names").doc(documentId).set({"names": categories});

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Category $categoryName added successfully")));
    emit (AddedCategory());
  }

  addOffer(context, {required String category,
    required String furnID,
    required List<String> color,
    required FileOrURL image}) async {
    emit(AddingOffer());


    // get id
    var documentId = await FirebaseFirestore.instance.collection("offer").doc().id;


    // add to offers
    Map<String, dynamic> newOffer = {};

    if (image.file != null) {
      await FirebaseStorage.instance.ref(
          'offers/${image.urlController.text}')
          .putData(image.file!)
          .then((p0) async {
        String url = await p0.ref.getDownloadURL();
        image.urlController.text = url;
      });
    }
    newOffer["img"] = image.urlController.text;
    newOffer["colors"] = color;
    newOffer["salesId"] = furnID;
    newOffer["category"] = category;
    offers.add(newOffer);

    // add category to firebase
    await FirebaseFirestore.instance.collection("offer").doc(documentId).set(newOffer);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("offer  added successfully")));
    emit (AddedOffer());
  }

  getOrders({limit = 0}) async {
    if (moreOrdersAvailable == false){
      return;
    }
    emit(LoadingOrderState());
    //print("ttttttttttttttttttttttttttttttttttt");
    print(limit);


   // if (limit == 0 && moreOrdersAvailable != false)
    if (limit == 0)
      {
      await FirebaseFirestore.instance.collection("order").limit(3).get().then((
          snapshot) {
        if (snapshot.docs.length < 3 ) {
          moreOrdersAvailable = false;
        }
        snapshot.docs.forEach((element) {

          orders.add(OrderModel.fromJson(element.data()));
        });


        lastDocumentOrderId = snapshot.docs.last;
        print("hello");
      });
    }
    else //if (limit !=0 && moreOrdersAvailable != false )
    {      //print(lastDocumentOrderId);
      await FirebaseFirestore.instance.collection("order").startAfterDocument(lastDocumentOrderId!).limit(limit).get().then((snapshot) {
        print(snapshot);
        if (snapshot.docs.length < limit){
          moreOrdersAvailable = false;
        }
        if (snapshot.docs.length > 0) {
          lastDocumentOrderId=snapshot.docs.last;
          snapshot.docs.forEach((element) {
            orders.add(OrderModel.fromJson(element.data()));

          });
        }
       // lastDocumentOrderId=snapshot.docs.last;
    });}

    emit(LoadedOrderState());
    // if (sizeOrder == orders.length) {
    //   moreOrdersAvailable = false;
    // }
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

  getSearchData(String categoryName, String searchbarName) async {
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
      if (snapshot.docs.length < 6) {
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

  getMoreSearchData(String categoryName, String searchbarName) async {
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
      if (snapshot.docs.length < 6) {
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
    })
        .catchError((error) => print("Error: " + error.toString()));
    print("ANA 5LAST GET MORE DATAAAAAAA  $searchbarName");
    if (sizeFurniture == furnitureList.length) {
      moreFurnitureAvailable = false;
    }
  }

  getYearsList() async {
    await FirebaseFirestore.instance
        .collection("years")
        .get()
        .then((value) {
          value.docs.forEach((element) async {
            print(element.data().values.toList()[0]);
            for(var year in element.data().values.toList()[0]){
              years.add(year);
            }
            print(years);
          });
        }).catchError((error) => print(error));
  }

  getStatisticsByYear(String year) async{
    emit(LoadingStatistics());
    print("YEARRRRRRRRRRRRRRRRRRR " + year);
    for (int i = 0; i < categories.length; i++) {
      categoriesIncome[categories[i]["name"]] = 0;
      categoriesOrders[categories[i]["name"]] = 0;
    }
    monthlyOrders = {
      "Jan": 0,
      "Feb": 0,
      "Mar": 0,
      "Apr": 0,
      "May": 0,
      "Jun": 0,
      "Jul": 0,
      "Aug": 0,
      "Sep": 0,
      "Oct": 0,
      "Nov": 0,
      "Dec": 0
    };
    totalIncome = 0;
    totalOrders = 0;
    maxIncome = 0;
    maxMonthlyOrders = 0;
    double totalItems = 0;

    //if(!statisticsData.containsKey(year)) {
      await FirebaseFirestore.instance.collection("statistics").where("year", isEqualTo: year).get()
          .then((snapshot) {
            statisticsData[year] = [];
            if(snapshot.docs.isNotEmpty) {
              for (var element in snapshot.docs) {
                Statistics tempStatistics = Statistics.fromJson(element.data());
                statisticsData[year]?.add(tempStatistics);
              }
            }
      }).catchError((error) => print("Error: " + error.toString()));
    //}
      statisticsData[year]?.forEach((element) {
        totalIncome+=double.parse(element.income);
        totalOrders+=double.parse(element.ordersNumber);
        monthlyOrders[months[int.parse(element.month) - 1]] = double.parse(element.ordersNumber);
        if (double.parse(element.ordersNumber) > maxMonthlyOrders) {
          maxMonthlyOrders = double.parse(element.ordersNumber);
        }
        element.category.forEach((key, value) {
          categoriesOrders[key] = categoriesOrders[key] + double.parse(value.count);
          categoriesIncome[key] = categoriesIncome[key] + double.parse(value.payment);
          // totalIncome = totalIncome + double.parse(value.payment);
          totalItems = totalItems + double.parse(value.count);
          if (double.parse(value.payment) > maxIncome) {
            maxIncome = double.parse(value.payment);
          }
        });
      });
      categoriesOrders.forEach((key, value) {
        categoriesOrders[key] = categoriesOrders[key] / totalItems * 100;
      });
      emit(LoadedStatistics());
  }

  updateFurniture(BuildContext context,
      {required FurnitureModel oldFurniture,
        required String furnitureName,
        required FileOrURL model,
        required String furnitureDescription,
        required List<SharedProperties> myShared}) async {
    emit(UpdatingFurnitureInProgressState());
    bool doesExistInFirestore = false;
    await FirebaseFirestore.instance
        .collection("category")
        .doc(oldFurniture.category)
        .collection("furniture")
        .where("name", isEqualTo: furnitureName)
        .get()
        .catchError((error) {
      emit(UpdatedFurnitureErrorState());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$furnitureName already exists")));
      doesExistInFirestore = true;
    });
    if (doesExistInFirestore == true) {
      return;
    }
    // String modelLink="";
    print("yarb");
    print(oldFurniture.model.startsWith("https://firebasestorage"));

    //TODO :COMMENT kol l t7t w agrb da bs
    if (oldFurniture.model.startsWith("https://firebasestorage")) {
      print("hleh");
      try {
        await FirebaseStorage.instance.refFromURL(oldFurniture.model).delete();
      } catch (e) {}
    }
    if (model.file != null) {
      await FirebaseStorage.instance
          .ref(
          'furniture/${oldFurniture.category}/${oldFurniture
              .furnitureId}_${model.urlController.text}')
          .putData(model.file!)
          .then((p0) async {
        String url = await p0.ref.getDownloadURL();
        model.urlController.text = url;
        print(url);
      });
    }
    List<SharedModel> shared = [];
    for (int i = 0; i < myShared.length; i++) {
      print(myShared[i].image.urlController.text);
      print(myShared[i].quantity.text);
      if (myShared[i].image.file != null) {
        //Will upload to server
        if (i < oldFurniture.shared.length) {
          //checking if shared exist
          if (oldFurniture.shared[i].image
              .startsWith("https://firebasestorage")) {
            //if shared is stored in firebase
            await FirebaseStorage.instance
                .refFromURL(oldFurniture.shared[i].image)
                .delete();
          }
        }
        await FirebaseStorage.instance
            .ref(
            'furniture/${oldFurniture.category}/${oldFurniture
                .furnitureId}_${myShared[i].image.urlController.text}')
            .putData(myShared[i].image.file!)
            .then((p0) async {
          String url = await p0.ref.getDownloadURL();
          myShared[i].image.urlController.text = url;
          print(url);
        });
      } else {
        if (i < oldFurniture.shared.length) {
          //checking if shared exist
          if (oldFurniture.shared[i].image
              .startsWith("https://firebasestorage") &&
              oldFurniture.shared[i].image !=
                  myShared[i].image.urlController.text) {
            //if shared is stored in firebase
            await FirebaseStorage.instance
                .refFromURL(oldFurniture.shared[i].image)
                .delete();
          }
        }
      }
      shared.add(SharedModel(
          color: myShared[i].color.text,
          colorName: myShared[i].colorName.text,
          image: myShared[i].image.urlController.text,
          price: myShared[i].price.text,
          quantity: myShared[i].quantity.text,
          discount: myShared[i].discount.text));
    }

    FurnitureModel tempFurniture = copyFurniture(oldFurniture);
    tempFurniture.name = furnitureName;
    tempFurniture.description = furnitureDescription;
    tempFurniture.model = model.urlController.text;
    print("ya rb");
    print(tempFurniture.shared.first.quantity);
    tempFurniture.shared = shared;
    print(tempFurniture.shared.first.quantity);

    // print(furnitureModel.shared.first.image);
    await FirebaseFirestore.instance
        .collection("category")
        .doc(tempFurniture.category)
        .collection("furniture")
        .doc(tempFurniture.furnitureId)
        .set(tempFurniture.toMap())
        .then((value) {
      assignByReference(tempFurniture, oldFurniture);
      oldFurniture.shared = shared;
      emit(UpdatedFurnitureSuccessState());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$furnitureName updated successfully")));
    }).catchError((error) {
      print("error");
      emit(UpdatedFurnitureErrorState());
    });
    // print("Done");
    // furnitureList.add(furnitureModel);
  }

  assignByReference(FurnitureModel copiedFrom, FurnitureModel copiedTo) {
    copiedTo.furnitureId = copiedFrom.furnitureId;
    copiedTo.ratings = copiedFrom.ratings;
    copiedTo.model = copiedFrom.model;
    copiedTo.description = copiedFrom.description;
    copiedTo.name = copiedFrom.name;
    //all is assigned except shared
  }

  FurnitureModel copyFurniture(FurnitureModel oldFurniture) {
    FurnitureModel newFurniture = FurnitureModel(
        description: oldFurniture.description,
        furnitureId: oldFurniture.furnitureId,
        name: oldFurniture.name,
        model: oldFurniture.model,
        category: oldFurniture.category,
        shared: oldFurniture.shared
            .map((e) => SharedModel.fromJson(e.toMap()))
            .toList(),
        ratings: oldFurniture.ratings);
    return newFurniture;
  }

  List<Map<String, dynamic>> copyCategory(tempCategory) {
    List<Map<String, dynamic>> tempMap = [];
    print("lol");
    for (int i = 0; i < categories.length; i++) {
      tempMap.add({});
      tempMap.last["name"] = categories[i]["name"].toString();
      tempMap.last["image"] = categories[i]["image"].toString();
    }
    return tempMap;
  }

  updateCategory(context,
      {required int index, required FileOrURL image}) async {
    emit(UpdatingCategoryInProgressState());
    if (categories[index]["image"].startsWith("https://firebasestorage")) {
      print("hdelete aho");
      try {
        await FirebaseStorage.instance
            .refFromURL(categories[index]["image"])
            .delete();
      } catch (e) {}
    }
    if (image.file != null) {
      await FirebaseStorage.instance
          .ref('category_icons/${image.urlController.text}')
          .putData(image.file!)
          .then((p0) async {
        String url = await p0.ref.getDownloadURL();
        image.urlController.text = url;
        print(url);
      });
    }

    List<Map<String, dynamic>> tempMap = copyCategory(categories);
    tempMap[index]["image"] = image.urlController.text;
    await FirebaseFirestore.instance
        .collection("names")
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("names")
          .doc(value.docs.first.id)
          .set({"names": tempMap});
    }).then((value) {
      categories[index]["image"] = image.urlController.text;
      print(categories.last["image"]);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${categories[index]["name"]} updated successfully")));
      emit(UpdatedCategorySuccessState());
    }).catchError((error) {
      emit(UpdatedCategoryErrorState());
    });
  }

  deleteCategory(context,index) async {
    //1. awl 7aga mafrood ashoof l items l mwgooda m3aya fl furnitureList
    //w atl3ha mnhom
    //2. F hroo7 a delete them mn firestore w kol soora ashoof leeha link
    //firebase storage aroo7 adelete
    //3. b3d kda aroo7 ageeb l hytb2o mn firestore ageebhom kolhom
    //w a3mlhom delete kolhom w bardo hdelete l mwgood fe firebase storage
    //4. b3d kda l offers hroo7 a3mlha delete kolha bl sowar bt3tha
    //5. kda ytb2a eny a delete document mn category
    //6. a3ml update lel names w asheel mn firestore
    List<FurnitureModel> requiredToDelete = furnitureList
        .where((element) => element.category == categories[index]["name"])
        .toList();
    furnitureList.removeWhere(
            (element) => element.category == categories[index]["name"]);
    for (int i = 0; i < requiredToDelete.length; i++) {
      for (int j = 0; j < requiredToDelete[i].shared.length; i++) {
        if (requiredToDelete[i]
            .shared[j]
            .image
            .startsWith("https://firebasestorage")) {
          try {
            await FirebaseStorage.instance
                .refFromURL(requiredToDelete[i].shared[j].image)
                .delete();
          } catch (e) {}
        }
      } //delete photos mn firebaseStorage
      await FirebaseFirestore.instance
          .collection("category")
          .doc(categories[index]["name"])
          .collection("furniture")
          .doc(requiredToDelete[i].furnitureId)
          .delete();
    }
    requiredToDelete = [];
   await FirebaseFirestore.instance
        .collection("category")
        .doc(categories[index]["name"])
        .collection("furniture")
        .get()
        .then((value) async {
      List<String> docIdsToDelete = value.docs.map((e) => e.id).toList();
      for (var element in value.docs) {
        for (var shared in element["shared"]) { //deleting photos
          if (shared["image"]
              .startsWith("https://firebasestorage")) {
            try {
              await FirebaseStorage.instance.refFromURL(shared["image"])
                  .delete();
            } catch (e) {}
          }
        }
      }
      for (int i = 0; i < docIdsToDelete.length; i++) {
        await FirebaseFirestore.instance
            .collection("category")
            .doc(categories[index]["name"])
            .collection("furniture")
            .doc(docIdsToDelete[i])
            .delete();
      }
    });


    await FirebaseFirestore.instance.collection("offer").where(
        "category", isEqualTo: "test_amr").get().then((value) async {
      for (var doc in value.docs) {
        if (doc["img"]
            .startsWith("https://firebasestorage")) {
          try{
          await FirebaseStorage.instance.refFromURL(doc["img"]).delete();
        }
        catch(e){}
        }
      }
      for (var docIdToDelete in value.docs.map((e) => e.id).toList()) {
        await FirebaseFirestore.instance.collection("offer")
            .doc(docIdToDelete)
            .delete();
      }
    });

    await FirebaseFirestore.instance.collection("category").doc(categories[index]["name"]).delete();

    List<Map<String, dynamic>> tempMap = copyCategory(categories);
    tempMap.removeAt(index);
    await FirebaseFirestore.instance
        .collection("names")
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("names")
          .doc(value.docs.first.id)
          .set({"names": tempMap});
    }).then((value) {
      categories.removeAt(index);
      emit(UpdatedCategorySuccessState());
    }).catchError((error) {
      emit(UpdatedCategoryErrorState());
    });
  }

  Color? getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }

  List<Color?> getAvailableColorsOfFurniture(FurnitureModel selectedFurniture) {
    availableColors.clear();
    for (int i = 0; i < selectedFurniture.shared.length; i++) {
      availableColors.add(getColorFromHex(selectedFurniture.shared[i].color));
    }
    return availableColors;
  }

  deleteFurniture(FurnitureModel deletedFurniture) async {
    emit(deletingFurnitureState());
    if (deletedFurniture.model.startsWith("https://firebasestorage")) {
      try {
        await FirebaseStorage.instance
            .refFromURL(deletedFurniture.model)
            .delete();
      } catch (e) {}
    }
    for (int i = 0; i < deletedFurniture.shared.length; i++) {
      if (deletedFurniture.shared[i].image
          .startsWith("https://firebasestorage")) {
        try {
          await FirebaseStorage.instance
              .refFromURL(deletedFurniture.shared[i].image)
              .delete();
        } catch (e) {}
      }
    }
    await FirebaseFirestore.instance.collection("category").doc(deletedFurniture.category).collection("furniture").doc(deletedFurniture.furnitureId).delete() .then((_) {
      print("deleted!");
      emit(deletedFurnitureSucessfullyState());
    });
  }

  logout(context) async {
    await FirebaseAuth.instance.signOut();
    //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LandingPage()), (route) => false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LandingPage()));
  }
}
