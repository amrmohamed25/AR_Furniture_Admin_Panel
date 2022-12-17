import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/models/furniture_model.dart';
import 'package:ar_furniture_admin_panel/models/shared_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/add_furniture_screen.dart';

class AdminCubit extends Cubit<AdminStates>{
  AdminCubit():super(InitialAdminState());

  List<Map<String,dynamic>> categories=[];

  getAllData()async{
    emit(LoadingAllData());
    // await getCategories();
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

  addFurniture(context,{required String furnitureName,required FileOrURL model,required String furnitureCategory,required String furnitureDescription,required List<SharedProperties> myShared})async{
    emit(UploadingFurnitureInProgressState());
    bool doesExistInFirestore=false;
    await FirebaseFirestore.instance.collection("category").doc(furnitureCategory).collection("furniture").where("name",isEqualTo: furnitureName).get().catchError((error){
      emit(UploadingFurnitureErrorState());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$furnitureName already exists")));
      doesExistInFirestore=true;
    });
    if(doesExistInFirestore==true){
      return;
    }
    // String modelLink="";
    var doc=FirebaseFirestore.instance.collection("category").doc(furnitureCategory).collection("furniture").doc().id;
    if(model.file!=null){
      await FirebaseStorage.instance.ref('furniture/${furnitureCategory}/${doc}_${model.urlController.text}').putData(model.file!).then((p0)async {
        String url=await p0.ref.getDownloadURL();
        model.urlController.text=url;
        print(url);
      });
    }
    print(doc);
    List<SharedModel> shared=[];
    for(int i =0;i<myShared.length;i++){
      print(myShared[i].image.urlController.text);
      if(myShared[i].image.file!=null) {
        await FirebaseStorage.instance.ref('furniture/${furnitureCategory}/${doc}_${myShared[i].image.urlController.text}').putData(myShared[i].image.file!).then((p0)async {
          String url=await p0.ref.getDownloadURL();
          myShared[i].image.urlController.text=url;
        });
      }
      shared.add(SharedModel(color:myShared[i].color.text,colorName:myShared[i].colorName.text,
          image:myShared[i]
      .image.urlController.text,price:myShared[i].price.text,quantity:myShared[i].quantity.text,
          discount:myShared[i].discount.text));
    }

    FurnitureModel furnitureModel=FurnitureModel(description: furnitureDescription,furnitureId: doc, name: furnitureName, model: model.urlController.text, category: furnitureCategory, shared: shared, ratings: {});
    print(furnitureModel.shared.first.image);
    await FirebaseFirestore.instance.collection("category").doc(furnitureCategory).collection("furniture").doc(doc).set(
      furnitureModel.toMap()
    );
    print("Done");
    emit(UploadingFurnitureSuccessState());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$furnitureName added successfully")));
  }
}