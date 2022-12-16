import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/responsive.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class FurnitureScreen extends StatefulWidget {
  static String selectedCategoryName = "";
  static int selectedCategoryIndex = -1;
  @override
  const FurnitureScreen({Key? key}) : super(key: key);
  @override
  State<FurnitureScreen> createState() => FurnitureScreenState();
}

class FurnitureScreenState extends State<FurnitureScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext) {
    return DashboardScreen(
      Column(
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
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            FurnitureScreen.selectedCategoryName =
                                "categoryname";
                            FurnitureScreen.selectedCategoryIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 3.2,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: index ==
                                          FurnitureScreen.selectedCategoryIndex
                                      ? primaryColor
                                      : backgroundColor,
                                )
                              ],
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width / 2),
                              color: secondaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Expanded(
                                    child: CircleAvatar(
                                  radius: MediaQuery.of(context).size.width / 9,
                                  backgroundColor: Colors.grey[300],
                                  // radius: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.network(
                                      "https://firebasestorage.googleapis.com/v0/b/ar-furniture-7fb69.appspot.com/o/category_icons%2Fdouble-bed.png?alt=media&token=2f18edbe-b15f-43aa-b9e3-479651b52d4f",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Categoryname",
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
              // margin: EdgeInsets.all(10),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.blue.shade400),
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: DataTable(
                    //border: TableBorder.symmetric(outside: BorderSide(width: 1)),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Furniture id',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Available Colors',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Price',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Available quantity',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Actions',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          const DataCell(Text('123test')),
                          const DataCell(Text('red,green')),
                          const DataCell(Text('EGP200,EGP300')),
                          const DataCell(Text('200,300')),
                          DataCell(
                            Row(
                              children: [
                                InkWell(
                                  child: const Icon(Icons.add),
                                  onTap: () {
                                    //action code when clicked
                                    print("The icon add is clicked");
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
                      ),
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
