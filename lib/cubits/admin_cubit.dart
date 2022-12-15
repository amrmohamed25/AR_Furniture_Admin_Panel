import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/models/furniture_model.dart';
import 'package:ar_furniture_admin_panel/models/shared_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/add_furniture_screen.dart';

class AdminCubit extends Cubit<AdminStates>{
  AdminCubit():super(InitialAdminState());

  List<Map<String,dynamic>> categories=[];

  getAllData()async{
    emit(LoadingAllData());
    await getCategories();
    emit(LoadedAllData());
  }

  getCategories()async{
    print("sad");
   await FirebaseFirestore.instance.collection("names").get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.data());
        Map<String,dynamic> data=doc.data() as Map<String,dynamic>;

        for(var i in data["names"]){
          // print(i["name"]);
          categories.add(i);
        }
      });
    });
   emit(GetAllCategoriesState());
  }

  addFurniture({required String furnitureName,required String model,required String furnitureCategory,required String furnitureDescription,required List<SharedProperties> myShared})async{
    var doc=await FirebaseFirestore.instance.collection("category").doc(furnitureCategory).collection("furniture").doc().id;
    print(doc);
    List<SharedModel> shared=[];
    for(int i =0;i<myShared.length;i++){
      print(myShared[i].image.text);
      shared.add(SharedModel(color:myShared[i].color.text,colorName:myShared[i].colorName.text,
          image:myShared[i]
      .image.text,price:myShared[i].price.text,quantity:myShared[i].quantity.text,
          discount:myShared[i].discount.text));
    }
    FurnitureModel furnitureModel=FurnitureModel(furnitureId: doc, name: furnitureName, model: model, category: furnitureCategory, shared: shared, ratings: {});
    print(furnitureModel.shared.first.image);
    await FirebaseFirestore.instance.collection("category").doc(furnitureCategory).collection("furniture").doc(doc).set(
      furnitureModel.toMap()
    );
    print("Done");
  }
}