import 'package:ar_furniture_admin_panel/cubits/admin_cubit.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/responsive.dart';
import 'package:ar_furniture_admin_panel/screens/furniture_screen.dart';
import 'package:ar_furniture_admin_panel/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class DashboardScreen extends StatefulWidget {
  @override
  Widget screen;

  DashboardScreen(this.screen);

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is LoadingAllData
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Responsive(
              mobile: Scaffold(
                key: scaffoldKey,
                drawer: Container(
                    width: MediaQuery.of(context).size.width * 0.53,
                    color: secondaryColor,
                    child: Column(
                      children: [
                        DrawerHeader(
                          child: Row(
                            children: [
                              FlutterLogo(
                                size: 18,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Admin Dashboard",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                              Row()
                            ],
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          horizontalTitleGap: 0.0,
                          leading: Icon(
                            Icons.dashboard,
                            color: Colors.black,
                            size: 10,
                          ),
                          title: Text(
                            "Dashboard",
                            style: TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                        ),
                        // ListTile(
                        //   onTap: () {},
                        //   horizontalTitleGap: 0.0,
                        //   leading: Icon(
                        //     Icons.category,
                        //     color: Colors.black,
                        //     size: 10,
                        //   ),
                        //   title: Text(
                        //     "Category",
                        //     style: TextStyle(
                        //         color: Colors.black, fontSize: 12),
                        //   ),
                        // ),
                        ListTile(
                          onTap: () async {
                            print("mmmmm");
                            if (BlocProvider.of<AdminCubit>(context).orders.isEmpty) {
                              await BlocProvider.of<AdminCubit>(context).getOrders();
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderScreen()));
                          },
                          horizontalTitleGap: 0.0,
                          leading: Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                            size: 12,
                          ),
                          title: Text(
                            "Orders",
                            style: TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            FurnitureScreen.selectedCategoryName =
                            BlocProvider.of<AdminCubit>(context)
                                .categories
                                .first["name"];
                            FurnitureScreen.selectedCategoryIndex =
                            0;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FurnitureScreen()));
                          },
                          horizontalTitleGap: 0.0,
                          leading: Icon(
                            Icons.event_seat,
                            color: Colors.black,
                            size: 12,
                          ),
                          title: Text(
                            "Furniture",
                            style: TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ],
                    )),
                appBar: AppBar(
                  backgroundColor: secondaryColor,
                  leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                ),
                body: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: backgroundColor,
                          child: widget.screen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              desktop: Scaffold(
                body: SafeArea(
                  child: Row(
                    children: [
                      Container(
                          width: 200,
                          height: double.infinity,
                          color: secondaryColor,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                DrawerHeader(
                                  child: Row(
                                    children: [
                                      FlutterLogo(
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Admin Dashboard",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      Row()
                                    ],
                                  ),
                                ),
                                // Row(
                                //     mainAxisAlignment:
                                //     MainAxisAlignment.center,
                                //     children: [
                                //       DrawerHeader(child:FlutterLogo(
                                //         size: 17,
                                //       ),),
                                //       Text(
                                //         "Furniture",
                                //         style: TextStyle(color:Colors.black,fontSize: 17),
                                //         textAlign: TextAlign.start,
                                //
                                //       ),
                                //
                                //     ]),
                                ListTile(
                                  onTap: () {},
                                  horizontalTitleGap: 0.0,
                                  leading: Icon(
                                    Icons.dashboard,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Dashboard",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                // ListTile(
                                //   onTap: () {},
                                //   horizontalTitleGap: 0.0,
                                //   leading: Icon(
                                //     Icons.category,
                                //     color: Colors.black,
                                //   ),
                                //   title: Text(
                                //     "Category",
                                //     style: TextStyle(
                                //         color: Colors.black, fontSize: 15),
                                //   ),
                                // ),
                                ListTile(
                                  onTap: () async {
                                    print("mmmmm");
                                    if (BlocProvider.of<AdminCubit>(context)
                                        .orders
                                        .isEmpty) {
                                      await BlocProvider.of<AdminCubit>(context)
                                          .getOrders();
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OrderScreen()));
                                  },
                                  horizontalTitleGap: 0.0,
                                  leading: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Orders",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    FurnitureScreen.selectedCategoryName =
                                    BlocProvider.of<AdminCubit>(context)
                                        .categories
                                        .first["name"];
                                    FurnitureScreen.selectedCategoryIndex =
                                    0;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FurnitureScreen()));
                                  },
                                  horizontalTitleGap: 0.0,
                                  leading: Icon(
                                    Icons.event_seat,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Furniture",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 4,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            //color: backgroundColor,
                            child: widget.screen),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}