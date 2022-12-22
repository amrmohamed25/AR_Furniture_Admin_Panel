// import 'dart:html';

import 'package:ar_furniture_admin_panel/cubits/admin_cubit.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/models/shared_model.dart';
import 'package:ar_furniture_admin_panel/responsive.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../models/order_model.dart';

class OrderScreen extends StatefulWidget {
  @override
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreen();
}

class _OrderScreen extends State<OrderScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // List <OrderModel> orders = [ OrderModel(orderId: "2", uid:" uid", userName: "userName", time: Timestamp(5,9), appartmentNumber: "2", area: "area", buildingNumber: "buildingNumber", floorNumber: "floorNumber", mobileNumber: "mobileNumber", streetName: "streetName", order:{})
  //   ,
  //   OrderModel(orderId: "2", uid:" uid", userName: "userName", time: Timestamp(5,9), appartmentNumber: "2", area: "area", buildingNumber: "buildingNumber", floorNumber: "floorNumber", mobileNumber: "mobileNumber", streetName: "streetName", order:{})
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadingOrderState)
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          return DashboardScreen(
            // return Scaffold(
            //   appBar: AppBar(
            //       centerTitle: true,
            //       backgroundColor: secondaryColor,
            //       title: Text(
            //         "Orders",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             fontStyle: FontStyle.italic),
            //       )),
            //   body:

            // GridView.builder(
            //     //shrinkWrap: true,
            //
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 3,
            //     mainAxisSpacing: 1,
            //     crossAxisSpacing: 1,
            //     childAspectRatio: 7,
            //
            //   ),
            //   itemCount: 10,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Center(
            //       child: Container(
            //
            //         color: Colors.grey,
            //         child: Text("Test"),
            //
            //         ),
            //
            //     );
            //   }
            // ),

            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height / 5,
                          margin: EdgeInsets.all(10),
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.blue.shade400),
                          //   borderRadius: BorderRadius.circular(10.0),
                          // ),

                          child: Text(
                            'Orders',
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 10,
                          shadowColor: secondaryColor,
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height/2,
                              alignment: Alignment.center,
                              // margin: EdgeInsets.all(10),
                              // decoration: BoxDecoration(
                              //   border: Border.all(color: Colors.blue.shade400),
                              //   borderRadius: BorderRadius.circular(10.0),
                              // ),

                              child: SizedBox(
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    //border: TableBorder.symmetric(outside: BorderSide(width: 1)),
                                    // decoration: BoxDecoration(
                                    //    border: Border.all(color: Colors.grey.shade400),
                                    //    borderRadius: BorderRadius.circular(10.0),
                                    //    ),
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          'Order id',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'User name',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'time',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Order details',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                        BlocProvider.of<AdminCubit>(context)
                                            .orders
                                            .length,
                                        (index) => orderDataRow(
                                            BlocProvider.of<AdminCubit>(context)
                                                .orders[index])),
                                    // DataRow(
                                    //   cells: [
                                    //     DataCell(Text('Janine')),
                                    //     DataCell(Text('43')),
                                    //     DataCell(Text('43')),
                                    //
                                    //
                                    //     DataCell(
                                    //       Row(
                                    //         children: [
                                    //           OutlinedButton(
                                    //               style: ElevatedButton.styleFrom(
                                    //
                                    //                   side: BorderSide(
                                    //                       width: 2,
                                    //                       color: Colors.black),
                                    //                   shape: RoundedRectangleBorder(
                                    //                       borderRadius:
                                    //                       BorderRadius.circular(15))),
                                    //               onPressed: () {},
                                    //               child: Text("Details",
                                    //                   style: TextStyle(
                                    //                       color: secondaryColor))),
                                    //         ],
                                    //       ),
                                    //
                                    //     ),
                                    //   ],
                                    // ),
                                    // DataRow(
                                    //   cells: [
                                    //     DataCell(Text('Janine')),
                                    //     DataCell(Text('43')),
                                    //     DataCell(Text('43')),
                                    //
                                    //     DataCell(
                                    //       Row(
                                    //         children: [
                                    //           OutlinedButton(
                                    //               style: ElevatedButton.styleFrom(
                                    //
                                    //                   side: BorderSide(
                                    //                       width: 2, color: Colors.black),
                                    //                   shape: RoundedRectangleBorder(
                                    //                       borderRadius:
                                    //                       BorderRadius.circular(15))),
                                    //               onPressed: () {},
                                    //               child: Text("Details",
                                    //                   style: TextStyle(color: secondaryColor))),
                                    //         ],
                                    //       ),
                                    //
                                    //     ),
                                    //   ],
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),

            // GridView.count(
            //    crossAxisCount: 4,
            //    childAspectRatio: 4,
            //    children: new List<Widget>.generate(16, (index) {
            //      return new GridTile(
            //        child: new Card(
            //            color: Colors.blue.shade200,
            //            child: new Center(
            //              child: new Text('tile $index'),
            //            )
            //        ),
            //      );
            //    }),
            //  ),
          );
        });

    // body: Container(
    //   color: Colors.white,
    //   padding: EdgeInsets.all(20.0),
    //   child: Table(
    //     border: TableBorder.all(color: Colors.grey),
    //     children: [
    //
    //       TableRow(children: [
    //         Text('Cell 1',
    //     textAlign: TextAlign.center,
    //     style: TextStyle(
    //         color: Colors.black,
    //         fontSize: 20,
    //         fontWeight: FontWeight.bold,
    //         fontStyle: FontStyle.italic),
    //   ),
    //         Text('Cell 2'),
    //         Text('Cell 3'),
    //       ]),
    //       TableRow(children: [
    //         Text('Cell 4'),
    //         Text('Cell 5'),
    //         Text('Cell 6'),
    //       ])
    //     ],
    //   ),
    // ));
  }

  DataRow orderDataRow(OrderModel orders) {
    return DataRow(
      cells: [
        DataCell(Text(orders.orderId)),
        DataCell(Text(orders.userName)),
        DataCell(Text(
            "${orders.time.toDate().day}/${orders.time.toDate().month}/${orders.time.toDate().year}")),
        DataCell(
          Row(
            children: [
              OutlinedButton(
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2, color: Colors.black),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {},
                  child:
                      Text("Details", style: TextStyle(color: secondaryColor))),
            ],
          ),
        ),
      ],
    );
  }
}
