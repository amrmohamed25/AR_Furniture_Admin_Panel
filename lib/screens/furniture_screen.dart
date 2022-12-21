import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/models/furniture_model.dart';
import 'package:ar_furniture_admin_panel/responsive.dart';
import 'package:ar_furniture_admin_panel/screens/add_furniture_screen.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:ar_furniture_admin_panel/screens/view_furniture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/admin_cubit.dart';

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
  List<FurnitureModel> filteredFurniture = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          filteredFurniture = BlocProvider.of<AdminCubit>(context)
              .furnitureList
              .where((element) =>
                  element.category == FurnitureScreen.selectedCategoryName)
              .toList();
          if (FurnitureScreen.selectedCategoryIndex == 0) {
            FurnitureScreen.selectedCategoryName =
                BlocProvider.of<AdminCubit>(context)
                    .categories[FurnitureScreen.selectedCategoryIndex]["name"];
          }
          ;

          return DashboardScreen(
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
                                                2),
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
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: (
                      ) {Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddFurnitureScreen()));},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Text('Add Furniture'), // <-- Text
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon( // <-- Icon
                                      Icons.add,
                                      size: 24.0,
                                    ),
                                  ],
                                ),

                                style: ElevatedButton.styleFrom(
                                  primary:  secondaryColor ,
                                ),
                              ),
                            ],
                          ),
                              SizedBox(height:10),
                              DataTable(
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
                                    filteredFurniture.length,
                                    (index) => FurnitureDataRow(
                                        filteredFurniture[index])),
                              ),
                              filteredFurniture.length < 10
                                  ? SizedBox(
                                      height: 10,
                                    )
                                  : Container(),
                              filteredFurniture.length < 10
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                                  size: 24.0,
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
      availableColors = furniture.shared[i].colorName + ",";
    }
    availableColors = availableColors +
        furniture.shared[furniture.shared.length - 1].colorName;
    for (int i = 0; i < furniture.shared.length - 1; i++) {
      prices = "EGP" + furniture.shared[i].price + ",";
    }
    prices =
        prices + "EGP" + furniture.shared[furniture.shared.length - 1].price;
    for (int i = 0; i < furniture.shared.length - 1; i++) {
      quantities = furniture.shared[i].quantity + ",";
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(ViewFurnitureScreen(selectedFurniture: furniture, availableColors: BlocProvider.of<AdminCubit>(context).getAvailableColorsOfFurniture(furniture)))));
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

  getMoreFurniture() async {
    print("hna");
    await BlocProvider.of<AdminCubit>(context)
        .getFurniture(FurnitureScreen.selectedCategoryName, limit: 5);
  }
}
