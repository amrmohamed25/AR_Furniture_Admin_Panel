import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_cubit.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../responsive.dart';

class SharedProperties {
  TextEditingController color;
  TextEditingController colorName;
  TextEditingController discount;
  TextEditingController image;
  TextEditingController price;
  TextEditingController quantity;

  SharedProperties(
      {required this.color,
      required this.colorName,
      required this.discount,
      required this.image,
      required this.price,
      required this.quantity});
}

class AddFurnitureScreen extends StatefulWidget {
  const AddFurnitureScreen({Key? key}) : super(key: key);

  @override
  State<AddFurnitureScreen> createState() => _AddFurnitureScreenState();
}

class _AddFurnitureScreenState extends State<AddFurnitureScreen> {
  var nameController = TextEditingController();
  var categoryController = TextEditingController();
  var modelController = TextEditingController();
  var descriptionController = TextEditingController();
  String value="";
  List<SharedProperties> sharedProperties = [
    SharedProperties(
      color: TextEditingController(),
      colorName: TextEditingController(),
      discount: TextEditingController(),
      image: TextEditingController(),
      price: TextEditingController(),
      quantity: TextEditingController(),
    ),
  ];


  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state){
        if(state is LoadedAllData)
          value=BlocProvider.of<AdminCubit>(context).categories.first["name"];
      },
      builder: (context,state){
        return state is LoadingAllData? Center(child: CircularProgressIndicator()):Responsive(
          mobile: const Scaffold(),
          desktop: Scaffold(
            appBar: AppBar(
              title: MaterialButton(
                hoverColor: Colors.transparent,
                onPressed: () {},
                child: const Text(
                  "Lem 3afshk",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
              decoration: const BoxDecoration(
                // image: const DecorationImage(image: AssetImage("assets/images/login_img.jpg"),fit: BoxFit.fill),

              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    // image: const DecorationImage(image: AssetImage("assets/images/login_img.jpg"),fit: BoxFit.fill),

                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 500,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Add Furniture",
                                style: TextStyle(
                                    fontFamily: "Montserrat", fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                hintText: "Name",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)
                                )
                            ),
                          ),
                          TextFormField(
                            controller: modelController,
                            decoration: const InputDecoration(
                                hintText: "3D Model",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Category: "),
                                SizedBox(width: 20,),
                                DropdownButton(value: value=="" ? null : value,items: BlocProvider.of<AdminCubit>(context).categories.map((e) => DropdownMenuItem<String>(value: e["name"],child: Text(e["name"]))).toList(), onChanged: (val){
                                  setState(() {
                                    value=val!;
                                  });
                                }),
                              ],
                            ),
                          ),
                          // ...BlocProvider.of<AdminCubit>(context).categories.map((e) => Text(e["name"])).toList(),
                          TextField(
                            decoration: const InputDecoration(
                                hintText: "Description",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)
                                )
                            ),
                            controller: descriptionController,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 150,
                                  // width: 100,
                                  child: ListView.builder(itemBuilder: (context,index){

                                    return buildExpansionTile("Variant $index",sharedProperties[index],index);
                                  },itemCount: sharedProperties.length,),
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    splashRadius: 15,
                                    icon: const Icon(Icons.add),
                                    onPressed: (){
                                      setState(() {
                                        sharedProperties.add(    SharedProperties(
                                          color: TextEditingController(),
                                          colorName: TextEditingController(),
                                          discount: TextEditingController(),
                                          image: TextEditingController(),
                                          price: TextEditingController(),
                                          quantity: TextEditingController(),
                                        ));
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],

                          ),
                          ElevatedButton(style: ElevatedButton.styleFrom(
                            minimumSize: Size(50,50),
                            backgroundColor: primaryColor,
                          ),onPressed: ()async{
                            print("aho");
                            print(sharedProperties[0].image.text);
                            await BlocProvider.of<AdminCubit>(context).addFurniture(furnitureName: nameController.text, model: modelController.text, furnitureCategory: value, furnitureDescription: descriptionController.text, myShared: sharedProperties);
                          }, child: Text("Add Furniture"))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },

    );
  }

  Widget buildExpansionTile(variant,sharedProperty,index){
    return ExpansionTile(title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(variant),
        if(sharedProperties.length!=1) IconButton(splashRadius: 15,onPressed: (){
          if(sharedProperties.length!=1) {
            setState(() {
              sharedProperties.removeAt(index);

            });
          }
        }, icon: const Icon(Icons.delete))
      ],
    ),
    children: [
      TextFormField(
        controller: sharedProperty.image,
        decoration:  InputDecoration(
            hintText: "Image link or upload",
            suffixIcon: IconButton(onPressed: (){

            }, icon: const Icon(Icons.attach_file)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            )
        ),
      ),
      TextFormField(
        controller: sharedProperty.quantity,
        decoration: const InputDecoration(
            hintText: "Quantity",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            )
        ),
      ),
      TextFormField(
        controller: sharedProperty.discount,
        decoration: const InputDecoration(
            hintText: "Discount",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            )
        ),
      ),
      TextFormField(
        controller: sharedProperty.colorName,
        decoration: const InputDecoration(
            hintText: "Color Name ex:red",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            )
        ),
      ),
      TextFormField(
        controller: sharedProperty.color,
        decoration: const InputDecoration(
            hintText: "Color code ex: #FF0000",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            )
        ),
      ),
      TextFormField(
        controller: sharedProperty.price,
        decoration: const InputDecoration(
            hintText: "Price",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            )
        ),
      ),

    ],);
  }
}
