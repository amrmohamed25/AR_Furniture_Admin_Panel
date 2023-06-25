import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/models/furniture_model.dart';
import 'package:ar_furniture_admin_panel/screens/add_category_screen.dart';
import 'package:ar_furniture_admin_panel/screens/add_furniture_screen.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:ar_furniture_admin_panel/screens/edit_furniture_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ar_furniture_admin_panel/screens/view_furniture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../cubits/admin_cubit.dart';
import 'offers_screen.dart';

List<FurnitureModel> filteredFurniture = [];

class FurnitureScreen extends StatefulWidget {
  static String selectedCategoryName = "";
  static int selectedCategoryIndex = 0;
  @override
  const FurnitureScreen({Key? key}) : super(key: key);
  @override
  State<FurnitureScreen> createState() => FurnitureScreenState();
}

class FurnitureScreenState extends State<FurnitureScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<FurnitureModel> searchR = filteredFurniture;
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(FurnitureScreen.selectedCategoryName);
    _scrollController.addListener(() async {
      print("Listenerrrrr");
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          print("scrollend");
          await getMoreFurniture();
        }
      }
    });
  }

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
  Widget build(BuildContext) {
    // print("Building out");
    // if (FurnitureScreen.selectedCategoryIndex == -1) {
    //   FurnitureScreen.selectedCategoryName =
    //   BlocProvider.of<AdminCubit>(context)
    //       .categories[0]["name"];
    //   BlocProvider.of<AdminCubit>(context)
    //       .emit(LoadedFurnitureState());
    //
    // };
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // print("Building in");

          if (_searchController.text.toLowerCase() == '') {
            filteredFurniture = BlocProvider.of<AdminCubit>(context)
                .furnitureList
                .where((element) =>
                    element.category == FurnitureScreen.selectedCategoryName)
                .toList();
            searchR = [...filteredFurniture];
          }



          return state is LoadingAllData || state is deletingFurnitureState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : DashboardScreen(
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.height / 9,
                              margin: const EdgeInsets.all(10),
                              child: const Text(
                                'Furniture',
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.only(top: 2.0),
                            height: MediaQuery.of(context).size.height / 5,
                            child: ListView.builder(
                                itemCount: BlocProvider.of<AdminCubit>(context).categories.length + 1,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: const EdgeInsets.all(10),
                                      child: (index != BlocProvider.of<AdminCubit>(context).categories.length) ?
                                      InkWell(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 2.5),
                                        onTap: () {
                                          setState(() {
                                            FurnitureScreen.selectedCategoryName = BlocProvider.of<AdminCubit>(context).categories[index]["name"];

                                            FurnitureScreen.selectedCategoryIndex = index;
                                            filteredFurniture = BlocProvider.of<AdminCubit>(context)
                                                .furnitureList
                                                .where((element) =>
                                            element.category == FurnitureScreen.selectedCategoryName)
                                                .toList();
                                            searchItem(_searchController.text);
                                          });
                                          },
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context).size.width < 530 ? 120 : MediaQuery.of(context).size.width / 5.2,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: index == FurnitureScreen.selectedCategoryIndex ? primaryColor : backgroundColor,
                                                )
                                              ],
                                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 2.5),
                                              color: secondaryColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: CircleAvatar(
                                                      radius: MediaQuery.of(context).size.width / 5,
                                                      backgroundColor: Colors.grey[300],
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: Image.network(BlocProvider.of<AdminCubit>(context).categories[index]["image"],
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    )),
                                                const SizedBox(height: 2,),
                                                Text(
                                                  BlocProvider.of<AdminCubit>(context).categories[index]["name"],
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: index == FurnitureScreen.selectedCategoryIndex ? Colors.white : Colors.black),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Material(
                                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 22),
                                                        color: Colors.transparent,
                                                        child: IconButton(
                                                            splashRadius: MediaQuery.of(context).size.width / 22,
                                                            onPressed: () {
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    FileOrURL categoryImg = FileOrURL(urlController: TextEditingController());
                                                                    categoryImg.urlController.text = BlocProvider.of<AdminCubit>(context).categories[index]["image"];
                                                                    return StatefulBuilder(builder: (context, setState) {
                                                                      return AlertDialog(
                                                                        title: Text("Edit Category"),
                                                                        content: SizedBox(
                                                                          width: MediaQuery.of(context).size.width / 2,
                                                                          child: Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: TextFormField(
                                                                                  validator: (value) {
                                                                                    if (categoryImg.file == null) {
                                                                                      if (!Uri.parse(categoryImg.urlController.text).isAbsolute) {
                                                                                        return "Please enter a url or upload an image";
                                                                                      }
                                                                                    }
                                                                                    return null;
                                                                                    },
                                                                                  controller: categoryImg.urlController,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: "Image or upload",
                                                                                    enabled: categoryImg.file == null ? true : false,
                                                                                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                                                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              IconButton(
                                                                                  onPressed: () async {
                                                                                    print("hello");
                                                                                    await getFile(categoryImg, isImage: true);
                                                                                    },
                                                                                  icon: const Icon(Icons.attach_file)),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: () async {
                                                                                await BlocProvider.of<AdminCubit>(context).updateCategory(context, index: index, image: categoryImg);
                                                                                Navigator.of(context).pop();
                                                                                },
                                                                              child: Text("Save")),
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                                },
                                                                              child: Text("Cancel"))
                                                                        ],
                                                                      );
                                                                    });
                                                                  });
                                                              },
                                                            icon: Icon(Icons.edit)),
                                                      ),
                                                      Material(
                                                        color: Colors.transparent,
                                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 22),
                                                        child: IconButton(
                                                            splashRadius: MediaQuery.of(context).size.width / 22,
                                                            onPressed: () {
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return StatefulBuilder(builder: (context, setState) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                          "Warning Deleting Category",
                                                                          style: TextStyle(color: Colors.red),
                                                                        ),
                                                                        content: SizedBox(
                                                                          width: MediaQuery.of(context).size.width / 2,
                                                                          child: Text("Are you sure do you want to delete this category?"),
                                                                        ),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: () async {
                                                                                await BlocProvider.of<AdminCubit>(context).deleteCategory(context, index);
                                                                                Navigator.of(context).pop();
                                                                                },
                                                                              child: Text("Delete")),
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                                },
                                                                              child: Text("Cancel"))
                                                                        ],
                                                                      );
                                                                    });
                                                                  });
                                                              },
                                                            icon: Icon(Icons.delete)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                          : InkWell(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 2.5),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(AddCategoryScreen())));
                                          },
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context).size.width < 530 ? 120 : MediaQuery.of(context).size.width / 5.2,
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: primaryColor,
                                                )
                                              ],
                                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 2.5),
                                              color: thirdColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: (MediaQuery.of(context).size.width > 700) ?
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Add Category  ",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ],) : Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Add",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "Category",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                }),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 28),
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 1.4,
                              height: MediaQuery.of(context).size.height / 1.5,
                              decoration: BoxDecoration(
                                  // color:primaryColor
                                  ),
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: (MediaQuery.of(context)
                                                  .size
                                                  .width >
                                              800)
                                          ? Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DashboardScreen(AddFurnitureScreen())));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: thirdColor,
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: const [
                                                      Text(
                                                          'Add Furniture'), // <-- Text
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        // <-- Icon
                                                        Icons.add,
                                                        size: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: TextField(
                                                      controller:
                                                          _searchController,
                                                      cursorColor: primaryColor,
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.7),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.7),
                                                        ),
                                                        hintText:
                                                            'What are you looking for?',
                                                        prefixIcon: const Icon(
                                                          Icons.search,
                                                          color: Colors.black,
                                                          size: 25,
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 14.0,
                                                                bottom: 5.0,
                                                                top: 5.0),
                                                      ),
                                                      onChanged: (value) {
                                                        // filter search item by name
                                                        searchItem(value);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddFurnitureScreen()));
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: thirdColor,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: const [
                                                          Text(
                                                              'Add Furniture'), // <-- Text
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Icon(
                                                            Icons.add,
                                                            size: 12,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: TextField(
                                                          controller:
                                                              _searchController,
                                                          cursorColor:
                                                              primaryColor,
                                                          decoration:
                                                              InputDecoration(
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .white),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.7),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .white),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.7),
                                                            ),
                                                            hintText:
                                                                'What are you looking for?',
                                                            prefixIcon:
                                                                const Icon(
                                                              Icons.search,
                                                              color:
                                                                  Colors.black,
                                                              size: 25,
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 14.0,
                                                                    bottom: 5.0,
                                                                    top: 5.0),
                                                          ),
                                                          onChanged: (value) {
                                                            // filter search item by name
                                                            searchItem(value);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                    ),
                                    const SizedBox(height: 10),
                                    (searchR.isEmpty)?
                                    const Center(
                                      child: Text(
                                        "No items to show",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                        ),
                                      ),
                                    ):
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        //border: TableBorder.symmetric(outside: BorderSide(width: 1)),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        columns: const [
                                          DataColumn(
                                            label: Text(
                                              'Furniture ID',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Available Colors',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Price',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Available quantity',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Actions',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ],

                                        rows: List.generate(
                                            searchR.length,
                                            (index) => FurnitureDataRow(
                                                searchR[index])),
                                      ),
                                    ),
                                    const SizedBox(
                                            height: 15,
                                    ),
                                    ((searchR.isNotEmpty && BlocProvider.of<AdminCubit>(context).moreFurnitureCategory[FurnitureScreen.selectedCategoryName] == true && _searchController.text == "") || (BlocProvider.of<AdminCubit>(context).moreFurnitureAvailable == true && _searchController.text.toLowerCase() == BlocProvider.of<AdminCubit>(context).lastSearchbarName && BlocProvider.of<AdminCubit>(context).lastCategorySearch == FurnitureScreen.selectedCategoryName))
                                        ? Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    await getMoreFurniture();
                                                  },
                                                  style:
                                                    ElevatedButton.styleFrom(
                                                      backgroundColor: thirdColor,
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      Text(
                                                          'Load more'), // <-- Text
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.refresh,
                                                        size: 12.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }

  DataRow FurnitureDataRow(FurnitureModel furniture) {
    String availableColors = "";
    String prices = "";
    String quantities = "";
    for (int i = 0; i < furniture.shared.length - 1; i++) {
      availableColors = availableColors + furniture.shared[i].colorName + ",";
      // print("in for" +availableColors);
    }

    availableColors = availableColors +
        furniture.shared[furniture.shared.length - 1].colorName;
    // print("after for" +availableColors);
    for (int i = 0; i < furniture.shared.length - 1; i++) {
      prices = prices + "EGP" + furniture.shared[i].price + ",";
    }
    prices =
        prices + "EGP" + furniture.shared[furniture.shared.length - 1].price;
    for (int i = 0; i < furniture.shared.length - 1; i++) {
      quantities = quantities + furniture.shared[i].quantity + ",";
    }
    quantities =
        quantities + furniture.shared[furniture.shared.length - 1].quantity;
    return DataRow(
      cells: [
        DataCell(Text(furniture.furnitureId)),
        DataCell(Text(furniture.name)),
        DataCell(Text(availableColors)),
        DataCell(Text(prices)),
        DataCell(Text(quantities)),
        DataCell(
          Row(
            children: [
              InkWell(
                child: const Icon(Icons.remove_red_eye),
                onTap: () {
                  //action code when clicked
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen(
                              ViewFurnitureScreen(
                                  selectedFurniture: furniture,
                                  availableColors:
                                      BlocProvider.of<AdminCubit>(context)
                                          .getAvailableColorsOfFurniture(
                                              furniture)))));
                  print("The icon view is clicked");
                },
              ),
              const SizedBox(width: 10),
              InkWell(
                child: const Icon(Icons.edit),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DashboardScreen(EditFurnitureScreen(furniture))));
                  //action code when clicked
                  print("The icon edit is clicked");
                },
              ),
              const SizedBox(width: 10),
              InkWell(
                child: const Icon(Icons.delete),
                onTap: () {
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "Delete Furniture",
                    desc: "Are you sure you want to delete (${furniture.name})\n",
                    buttons: [
                      DialogButton(
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: primaryColor,
                          onPressed: () async {
                            Navigator.pop(context);
                            await BlocProvider.of<AdminCubit>(context)
                                .deleteFurniture(furniture);
                            filteredFurniture.remove(furniture);
                            searchR.remove(furniture);
                            BlocProvider.of<AdminCubit>(context).furnitureList.remove(furniture);
                          }),
                    ],
                    style: AlertStyle(
                      animationType: AnimationType.fromTop,
                      animationDuration: Duration(milliseconds: 400),
                      titleStyle: TextStyle(
                        color: Colors.red,
                      ),
                      descStyle: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ).show();
                  //action code when clicked
                  print("The icon delete is clicked");
                },
              ),
              const SizedBox(width: 10),
              InkWell(
                child: const Icon(Icons.percent),
                onTap: () {
                  //action code when clicked
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>DashboardScreen(OffersScreen(furniture))));
                  print("The icon discount offer is clicked");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> searchItem(String query) async {
    if (query != '') {
      final input = query.toLowerCase();
      List<FurnitureModel> suggestions = filteredFurniture.where((fur) {
        final searchTitle = fur.name.toLowerCase();
        return searchTitle.contains(input);
      }).toList();
      if(suggestions.length < 6) {
        int listLength = filteredFurniture.length;
        await getMoreFurniture();
        if(listLength != filteredFurniture.length) {
          suggestions = filteredFurniture.where((fur) {
            final searchTitle = fur.name.toLowerCase();
            return searchTitle.contains(input);
          }).toList();
        }
      }
      setState(() {
        searchR = [...suggestions];
      });
    } else {
      setState(() {
        searchR = [...filteredFurniture];
      });
    }
  }

  getMoreFurniture() async {
    if (_searchController.text.toLowerCase() == '' && BlocProvider.of<AdminCubit>(context).moreFurnitureCategory[FurnitureScreen.selectedCategoryName] == true) {
      await BlocProvider.of<AdminCubit>(context).getFurniture(FurnitureScreen.selectedCategoryName, limit: 5);

      filteredFurniture = BlocProvider.of<AdminCubit>(context)
          .furnitureList
          .where((element) =>
      element.category == FurnitureScreen.selectedCategoryName)
          .toList();

      setState(() {
        searchR = [...filteredFurniture];
      });

    } else if (_searchController.text.toLowerCase() != '' && BlocProvider.of<AdminCubit>(context).moreFurnitureCategory[FurnitureScreen.selectedCategoryName] == true) {
      int sizeFurniture = filteredFurniture.length;

      if (BlocProvider.of<AdminCubit>(context).lastSearchbarName == _searchController.text.toLowerCase() && BlocProvider.of<AdminCubit>(context).lastCategorySearch == FurnitureScreen.selectedCategoryName && BlocProvider.of<AdminCubit>(context).moreFurnitureAvailable == true) {
        await BlocProvider.of<AdminCubit>(context).getMoreSearchData(FurnitureScreen.selectedCategoryName, _searchController.text.toLowerCase());
      }else if (BlocProvider.of<AdminCubit>(context).lastSearchbarName != _searchController.text.toLowerCase()){
        await BlocProvider.of<AdminCubit>(context).getSearchData(FurnitureScreen.selectedCategoryName, _searchController.text.toLowerCase());
      }

      filteredFurniture = BlocProvider.of<AdminCubit>(context)
          .furnitureList
          .where((element) =>
      element.category == FurnitureScreen.selectedCategoryName)
          .toList();

      if (sizeFurniture != filteredFurniture.length) {
        searchItem(_searchController.text.toLowerCase());
      }

    }
  }
}
