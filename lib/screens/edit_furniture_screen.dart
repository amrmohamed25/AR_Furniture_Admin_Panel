import 'dart:io';
import 'dart:typed_data';

import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_cubit.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/models/furniture_model.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../responsive.dart';
import 'add_furniture_screen.dart';

class EditFurnitureScreen extends StatefulWidget {
  FurnitureModel furniture;

  EditFurnitureScreen(this.furniture);

  @override
  State<EditFurnitureScreen> createState() => _EditFurnitureScreenState();
}

class _EditFurnitureScreenState extends State<EditFurnitureScreen> {
  var nameController = TextEditingController();
  // FileOrURL model = FileOrURL(urlController: TextEditingController());
  var descriptionController = TextEditingController();
  List<SharedProperties> sharedProperties = [
    // SharedProperties(
    //   color: TextEditingController(),
    //   colorName: TextEditingController(),
    //   discount: TextEditingController(),
    //   image: FileOrURL(urlController: TextEditingController()),
    //   price: TextEditingController(),
    //   quantity: TextEditingController(),
    // ),
  ];

  getFile(FileOrURL shared, {isImage = false}) async {
    FilePickerResult? filePicker;
    // print(isImage);
    if (isImage == true) {
      // print(isImage);
      filePicker = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);
    } else {
      filePicker = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['glb']);
    }
    if (filePicker != null) {
      setState(() {
        shared.file = filePicker!.files.first.bytes!;
        shared.urlController.text = filePicker.files.first.name;
      });

      print(shared.urlController.text);
      // model.urlController.text=_filePicker.files.single.path!.split(".");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.furniture.name;
    // model.urlController.text = widget.furniture.model;
    descriptionController.text = widget.furniture.description ?? "";
    widget.furniture.shared.forEach((element) {
      sharedProperties.add(SharedProperties(
        model:FileOrURL(urlController: TextEditingController()),
        color: TextEditingController(),
        colorName: TextEditingController(),
        discount: TextEditingController(),
        image: FileOrURL(urlController: TextEditingController()),
        price: TextEditingController(),
        quantity: TextEditingController(),
      ));

      sharedProperties.last.color.text = element.color;
      sharedProperties.last.colorName.text = element.colorName;
      sharedProperties.last.discount.text = element.discount;
      sharedProperties.last.image.urlController.text = element.image;
      sharedProperties.last.price.text = element.price;
      sharedProperties.last.quantity.text = element.quantity;
      sharedProperties.last.model.urlController.text=element.model;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is UploadingFurnitureSuccessState) {
          nameController.text = "";
          // model.file = null;
          // model.urlController.text = "";
          descriptionController.text = "";
          sharedProperties = [
            SharedProperties(
              model:FileOrURL(urlController: TextEditingController()),
              color: TextEditingController(),
              colorName: TextEditingController(),
              discount: TextEditingController(),
              image: FileOrURL(urlController: TextEditingController()),
              price: TextEditingController(),
              quantity: TextEditingController(),
            ),
          ];
        }
      },
      builder: (context, state) {
        return state is LoadingAllData
            ? const Center(child: CircularProgressIndicator())
            : Responsive(
                mobile: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DashboardScreen(Container())));
                        //TODO: Navigate to previous SCREEN
                        // Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_backspace,
                        color: Colors.black,
                      ),
                    ),
                    centerTitle: true,
                    // title: const Text(
                    //   "Lem 3afshk",
                    //   style: TextStyle(
                    //       fontFamily: "Montserrat",
                    //       fontSize: 20,
                    //       color: Colors.black),
                    // ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: Container(
                    decoration: const BoxDecoration(
                        // image: const DecorationImage(image: AssetImage("assets/images/login_img.jpg"),fit: BoxFit.fill),

                        ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            // image: const DecorationImage(image: AssetImage("assets/images/login_img.jpg"),fit: BoxFit.fill),

                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 500,
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: const [
                                        Text(
                                          "Edit Furniture",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      controller: nameController,
                                      validator: (value) {
                                        if (!RegExp(r"^([a-z A-Z']+)$")
                                            .hasMatch(value.toString())) {
                                          return 'Please enter a valid name';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Name",
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey))),
                                    ),


                                    // ...BlocProvider.of<AdminCubit>(context).categories.map((e) => Text(e["name"])).toList(),
                                    TextFormField(
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Please enter description";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Description",
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey))),
                                      controller: descriptionController,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 150,
                                            // width: 100,
                                            child: ListView.builder(
                                              itemBuilder: (context, index) {
                                                return buildExpansionTile(
                                                    "Variant $index",
                                                    sharedProperties[index],
                                                    index);
                                              },
                                              itemCount:
                                                  sharedProperties.length,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              splashRadius: 15,
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                setState(() {
                                                  sharedProperties
                                                      .add(SharedProperties(
                                                    model:FileOrURL(urlController: TextEditingController()),
                                                    color:
                                                        TextEditingController(),
                                                    colorName:
                                                        TextEditingController(),
                                                    discount:
                                                        TextEditingController(),
                                                    image: FileOrURL(
                                                        urlController:
                                                            TextEditingController()),
                                                    price:
                                                        TextEditingController(),
                                                    quantity:
                                                        TextEditingController(),
                                                  ));
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    state is UpdatingFurnitureInProgressState
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(50, 50),
                                                  backgroundColor: primaryColor,
                                                ),
                                                onPressed: () async {
                                                  print(descriptionController
                                                      .text);
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    print("aho");
                                                    print(sharedProperties[0]
                                                        .image
                                                        .urlController
                                                        .text);
                                                    print(descriptionController
                                                        .text);
                                                    await BlocProvider.of<
                                                            AdminCubit>(context)
                                                        .updateFurniture(
                                                            context,
                                                            oldFurniture: widget
                                                                .furniture,
                                                            furnitureName:
                                                                nameController
                                                                    .text,
                                                            // model: model,
                                                            furnitureDescription:
                                                                descriptionController
                                                                    .text,
                                                            myShared:
                                                                sharedProperties);
                                                  }
                                                },
                                                child: const Text(
                                                    "Edit Furniture")),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                desktop: Scaffold(
                  appBar: AppBar(
                    leading: Container(),
                    // title: MaterialButton(
                    //   hoverColor: Colors.transparent,
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 DashboardScreen(Container())));
                    //
                    //     //TODO: navigate to HOMESCREEN
                    //   },
                    //   child: const Text(
                    //     "Lem 3afshk",
                    //     style: TextStyle(
                    //         fontFamily: "Montserrat",
                    //         fontSize: 20,
                    //         color: Colors.black),
                    //   ),
                    // ),
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
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        "Edit Furniture",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    validator: (value) {
                                      if (!RegExp(r"^([a-z A-Z']+)$")
                                          .hasMatch(value.toString())) {
                                        return 'Please enter a valid name';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Name",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey))),
                                  ),

                                  TextFormField(
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please enter description";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Description",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey))),
                                    controller: descriptionController,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 150,
                                          // width: 100,
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              return buildExpansionTile(
                                                  "Variant $index",
                                                  sharedProperties[index],
                                                  index);
                                            },
                                            itemCount: sharedProperties.length,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            splashRadius: 15,
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                sharedProperties
                                                    .add(SharedProperties(
                                                  model:FileOrURL(urlController: TextEditingController()),
                                                  color:
                                                      TextEditingController(),
                                                  colorName:
                                                      TextEditingController(),
                                                  discount:
                                                      TextEditingController(),
                                                  image: FileOrURL(
                                                      urlController:
                                                          TextEditingController()),
                                                  price:
                                                      TextEditingController(),
                                                  quantity:
                                                      TextEditingController(),
                                                ));
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  state is UpdatingFurnitureInProgressState
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(50, 50),
                                            backgroundColor: primaryColor,
                                          ),
                                          onPressed: () async {
                                            print(descriptionController.text);
                                            if (_formKey.currentState!
                                                .validate()) {
                                              print("aho");
                                              print(sharedProperties[0]
                                                  .image
                                                  .urlController
                                                  .text);
                                              print(descriptionController.text);
                                              await BlocProvider.of<AdminCubit>(
                                                      context)
                                                  .updateFurniture(context,
                                                      furnitureName:
                                                          nameController.text,
                                                      // model: model,
                                                      furnitureDescription:
                                                          descriptionController
                                                              .text,
                                                      myShared:
                                                          sharedProperties,
                                                      oldFurniture:
                                                          widget.furniture);
                                            }
                                          },
                                          child: const Text("Edit Furniture"))
                                ],
                              ),
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

  Widget buildExpansionTile(variant, sharedProperty, index) {
    return ExpansionTile(
      maintainState: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(variant),
          if (sharedProperties.length != 1 &&
              index >= widget.furniture.shared.length)
            IconButton(
                splashRadius: 15,
                onPressed: () {
                  if (sharedProperties.length != 1) {
                    setState(() {
                      sharedProperties.removeAt(index);
                    });
                  }
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (sharedProperty.image.file == null) {
                    if (!Uri.parse(sharedProperty.image.urlController.text)
                        .isAbsolute) {
                      return "Please enter a url or upload an image";
                    }
                  }
                  return null;
                },
                enabled: sharedProperty.image.file == null ? true : false,
                controller: sharedProperty.image.urlController,
                decoration: const InputDecoration(
                    hintText: "Image link or upload",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
            IconButton(
                onPressed: () async {
                  await getFile(sharedProperty.image, isImage: true);
                },
                icon: const Icon(Icons.attach_file)),
            if (sharedProperty.image.file != null)
              IconButton(
                  onPressed: () async {
                    setState(() {
                      sharedProperty.image.file = null;
                      sharedProperty.image.urlController.text = "";
                    });
                    // await getImage();
                  },
                  icon: const Icon(Icons.delete)),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (sharedProperty.model.file == null) {
                    if (!Uri.parse(sharedProperty.model
                        .urlController.text)
                        .isAbsolute) {
                      return "Please enter a url or upload a model";
                    }
                  }
                  return null;
                },
                controller: sharedProperty.model.urlController,
                decoration: InputDecoration(
                  hintText: "3D Model or upload",
                  enabled: sharedProperty.model.file == null
                      ? true
                      : false,
                  enabledBorder:
                  const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey)),
                  focusedBorder:
                  const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey)),
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  print("hello");
                  await getFile(sharedProperty.model);
                },
                icon:
                const Icon(Icons.attach_file)),
            if (sharedProperty.model.file != null)
              IconButton(
                  onPressed: () async {
                    setState(() {
                      sharedProperty.model.file = null;
                      sharedProperty.model.urlController.text = "";
                    });
                    // await getImage();
                  },
                  icon: const Icon(Icons.delete)),
          ],
        ),
        TextFormField(
          validator: (value) {
            if (value.toString().isEmpty) {
              return "Please enter a price";
            }
            if (int.tryParse(value.toString()) == null) {
              return "Please enter valid number";
            }
            if (int.tryParse(value.toString()) != null) {
              if (
              int.parse(value.toString()) < 0) {
                return "Please enter a valid price";
              }
            }
            return null;
          },
          controller: sharedProperty.quantity,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              hintText: "Quantity",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        TextFormField(
          validator: (value) {
            if (value.toString().isEmpty) {
              return "Please enter a discount";
            }
            if (double.tryParse(value.toString()) == null) {
              return "Please enter valid number";
            }
            if (double.tryParse(value.toString()) != null) {
              if ((double.parse(value.toString()) >= 100 ||
                  double.parse(value.toString()) < 0)) {
                return "Please enter a valid discount which is less than 100";
              }
            }

            return null;
          },
          controller: sharedProperty.discount,
          decoration: const InputDecoration(
              hintText: "Discount ex:25",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        TextFormField(
          controller: sharedProperty.colorName,
          validator: (value) {
            if (!RegExp(r"^([a-zA-Z']+)$").hasMatch(value.toString())) {
              return 'Please enter a valid color name';
            }
            return null;
          },
          decoration: const InputDecoration(
              hintText: "Color Name ex:red",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        TextFormField(
          validator: (value) {
            if (value.toString().isEmpty) {
              return "Color code shouldn't be empty";
            }
            if (value.toString().substring(0, 1) != "#") {
              return "Color code should start with #";
            }
            String scannedColorCode = value.toString();
            List<String> allowedChars = [];
            for (int i = 0; i <= 9; i++) {
              allowedChars.add(i.toString());
            }
            allowedChars.add("a");
            allowedChars.add("b");
            allowedChars.add("c");
            allowedChars.add("d");
            allowedChars.add("e");
            allowedChars.add("f");

            for (int i = 1; i < scannedColorCode.length; i++) {
              if (!allowedChars.contains(scannedColorCode[i].toLowerCase())) {
                return "Please enter a valid color code 0-F";
              }
            }
            if (value.toString().length != "#FF0000".length) {
              int validLength = "#FF0000".length;
              return "The color code should be exactly $validLength";
            }
            return null;
          },
          controller: sharedProperty.color,
          decoration: const InputDecoration(
              hintText: "Color code ex: #FF0000",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        TextFormField(
          validator: (value) {
            if (value.toString().isEmpty) {
              return "Please enter a price";
            }
            if (double.tryParse(value.toString()) == null) {
              return "Please enter valid number";
            }
            if (double.tryParse(value.toString()) != null) {
              if (
                  double.parse(value.toString()) < 0) {
                return "Please enter a valid price";
              }
            }

            return null;
          },
          keyboardType: TextInputType.number,
          controller: sharedProperty.price,
          decoration: const InputDecoration(
              hintText: "Price",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
      ],
    );
  }
}
