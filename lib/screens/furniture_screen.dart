import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/models/furniture_model.dart';
import 'package:ar_furniture_admin_panel/responsive.dart';
import 'package:ar_furniture_admin_panel/screens/add_furniture_screen.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/admin_cubit.dart';


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

  @override
  Widget build(BuildContext) {
    print("Building out");
    // if (FurnitureScreen.selectedCategoryIndex == -1) {
    //   FurnitureScreen.selectedCategoryName =
    //   BlocProvider.of<AdminCubit>(context)
    //       .categories[0]["name"];
    //   BlocProvider.of<AdminCubit>(context)
    //       .emit(LoadedFurnitureState());
    //
    // };
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          print("Building in");

          if(searchR.isEmpty || _searchController.text.toLowerCase() == '') {
            filteredFurniture = BlocProvider.of<AdminCubit>(context)
                .furnitureList
                .where((element) =>
            element.category == FurnitureScreen.selectedCategoryName)
                .toList();

          }
          if(searchR.isEmpty || _searchController.text.toLowerCase() == '') {
            searchR = [...filteredFurniture];
          }

          return state is LoadingAllData
          ?  Center(
            child: CircularProgressIndicator(),
          ):  DashboardScreen(
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
                            height: MediaQuery.of(context).size.height / 7,
                            child: ListView.builder(
                                itemCount: BlocProvider.of<AdminCubit>(context)
                                    .categories
                                    .length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: const EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            FurnitureScreen.selectedCategoryName =
                                            BlocProvider.of<AdminCubit>(context)
                                                .categories[index]["name"];

                                            FurnitureScreen.selectedCategoryIndex =
                                                index;
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          width:
                                          MediaQuery.of(context).size.width / 5.2,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: index ==
                                                      FurnitureScreen
                                                          .selectedCategoryIndex
                                                      ? primaryColor
                                                      : backgroundColor,
                                                )
                                              ],
                                              borderRadius: BorderRadius.circular(
                                                  MediaQuery.of(context).size.width /
                                                      2.5),
                                              color: secondaryColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: CircleAvatar(
                                                      radius: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                          9,
                                                      backgroundColor: Colors.grey[300],
                                                      // radius: 10,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(2.0),
                                                        child: Image.network(
                                                          BlocProvider.of<AdminCubit>(
                                                              context)
                                                              .categories[index]["image"],
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  BlocProvider.of<AdminCubit>(context)
                                                      .categories[index]["name"],
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: index ==
                                                          FurnitureScreen
                                                              .selectedCategoryIndex
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                }),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 28),
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
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: (MediaQuery.of(context).size.width > 800)?
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddFurnitureScreen()));
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text('Add Furniture'), // <-- Text
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
                                            style: ElevatedButton.styleFrom(
                                              primary: secondaryColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: TextField(
                                                controller: _searchController,
                                                cursorColor: primaryColor,
                                                decoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.circular(25.7),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.circular(25.7),
                                                  ),
                                                  hintText: 'What are you looking for?',
                                                  prefixIcon: const Icon(
                                                    Icons.search,
                                                    color: Colors.black,
                                                    size: 25,
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  contentPadding: const EdgeInsets.only(
                                                      left: 14.0, bottom: 5.0, top: 5.0),
                                                ),
                                                onChanged: (value) {
                                                  // filter search item by name
                                                  searchItem(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: primaryColor,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(Icons.filter_list, color: Colors.white, size: 25,),
                                              onPressed: () async{
                                                // filter
                                                // apply filter
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ):Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddFurnitureScreen()));
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Text('Add Furniture'), // <-- Text
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
                                                style: ElevatedButton.styleFrom(
                                                  primary: secondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: TextField(
                                                    controller: _searchController,
                                                    cursorColor: primaryColor,
                                                    decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Colors.white),
                                                        borderRadius: BorderRadius.circular(25.7),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Colors.white),
                                                        borderRadius: BorderRadius.circular(25.7),
                                                      ),
                                                      hintText: 'What are you looking for?',
                                                      prefixIcon: const Icon(
                                                        Icons.search,
                                                        color: Colors.black,
                                                        size: 25,
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding: const EdgeInsets.only(
                                                          left: 14.0, bottom: 5.0, top: 5.0),
                                                    ),
                                                    onChanged: (value) {
                                                      // filter search item by name
                                                      searchItem(value);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: primaryColor,
                                                ),
                                                child: IconButton(
                                                  icon: const Icon(Icons.filter_list, color: Colors.white, size: 25,),
                                                  onPressed: () async{
                                                    // filter
                                                    // apply filter
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        //border: TableBorder.symmetric(outside: BorderSide(width: 1)),
                                        decoration: BoxDecoration(
                                          border:
                                          Border.all(color: Colors.grey.shade400),
                                          borderRadius: BorderRadius.circular(10.0),
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
                                      ),),
                                    searchR.length < 10
                                        ? SizedBox(
                                      height: 15,
                                    )
                                        : Container(),
                                    searchR.length < 10
                                        ? Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 10),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await getMoreFurniture();
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text('Load more'), // <-- Text
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  // <-- Icon
                                                  Icons.refresh,
                                                  size: 12.0,
                                                ),
                                              ],
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: secondaryColor,
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
      print("in for" +availableColors);
    }

    availableColors = availableColors +
        furniture.shared[furniture.shared.length - 1].colorName;
    print("after for" +availableColors);
    for (int i = 0; i < furniture.shared.length - 1; i++) {

      prices = prices +"EGP" + furniture.shared[i].price + ",";
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
                  print("The icon view is clicked");
                },
              ),
              const SizedBox(width: 10),
              InkWell(
                child: const Icon(Icons.edit),
                onTap: () {
                  //action code when clicked
                  print("The icon edit is clicked");
                },
              ),
              const SizedBox(width: 10),
              InkWell(
                child: const Icon(Icons.delete),
                onTap: () {
                  //action code when clicked
                  print("The icon delete is clicked");
                },
              ),
              const SizedBox(width: 10),
              InkWell(
                child: const Icon(Icons.payments),
                onTap: () {
                  //action code when clicked
                  print("The icon add offer is clicked");
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  void searchItem (String query) {
    if (query != ''){
      final input = query.toLowerCase();
      List<FurnitureModel> suggestions = filteredFurniture.where((fur) {
        final searchTitle = fur.name.toLowerCase();
        return searchTitle.contains(input);
      }).toList();
      setState(() {
        searchR = [...suggestions];
      });
    } else{
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
