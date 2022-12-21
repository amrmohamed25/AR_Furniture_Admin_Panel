import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/responsive.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  //List<Map<String,dynamic>> furniture = [];
 OrderModel myOrder;
 OrderDetailsScreen(this.myOrder);
  @override
  Widget build(BuildContext context) {
    return DashboardScreen(Responsive(
      mobile: Container(),
      desktop: Container(
        // height: MediaQuery
        //     .of(context)
        //   .size
        //   .height - 100,
        decoration: BoxDecoration(color: secondaryColor),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height - 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.only(
                  // topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),


                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " Order Details ",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 4,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                               "Order id: ${myOrder.orderId}",
                              // overflow: TextOverflow.ellipsis,
                              // style: GoogleFonts.raleway(
                              //   textStyle: const TextStyle(
                              //       fontSize: 18, fontWeight: FontWeight.bold),

                             // "Order id :",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width - 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //color: Color(0xffFFF5EE),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // "Order id: ${myOrder.orderId}",
                                    // overflow: TextOverflow.ellipsis,
                                    // style: GoogleFonts.raleway(
                                    //   textStyle: const TextStyle(
                                    //       fontSize: 18, fontWeight: FontWeight.bold),

                                    "User Name : ${myOrder.userName}",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /4,
                                  ),
                                  Text(
                                    // "Order id: ${myOrder.orderId}",
                                    // overflow: TextOverflow.ellipsis,
                                    // style: GoogleFonts.raleway(
                                    //   textStyle: const TextStyle(
                                    //       fontSize: 18, fontWeight: FontWeight.bold),
                                    "Mobile number :${myOrder.mobileNumber}",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // "Order id: ${myOrder.orderId}",
                                    // overflow: TextOverflow.ellipsis,
                                    // style: GoogleFonts.raleway(
                                    //   textStyle: const TextStyle(
                                    //       fontSize: 18, fontWeight: FontWeight.bold),

                                    "Order time : ${myOrder.time.toDate().year.toString()}-${myOrder.time.toDate().month.toString()}-${myOrder.time.toDate().day.toString()}",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /5,
                                  ),
                                  Text(
                                    // "Order id: ${myOrder.orderId}",
                                    // overflow: TextOverflow.ellipsis,
                                    // style: GoogleFonts.raleway(
                                    //   textStyle: const TextStyle(
                                    //       fontSize: 18, fontWeight: FontWeight.bold),
                                    "Street Name : ${myOrder.streetName}",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // "Order id: ${myOrder.orderId}",
                                    // overflow: TextOverflow.ellipsis,
                                    // style: GoogleFonts.raleway(
                                    //   textStyle: const TextStyle(
                                    //       fontSize: 18, fontWeight: FontWeight.bold),

                                    "Area :${myOrder.area}",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /3.8,
                                  ),
                                  Text(
                                    // "Order id: ${myOrder.orderId}",
                                    // overflow: TextOverflow.ellipsis,
                                    // style: GoogleFonts.raleway(
                                    //   textStyle: const TextStyle(
                                    //       fontSize: 18, fontWeight: FontWeight.bold),
                                    "Building Name : ${myOrder.buildingNumber}",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    // "Order id: ${myOrder.orderId}",
                                    // overflow: TextOverflow.ellipsis,
                                    // style: GoogleFonts.raleway(
                                    //   textStyle: const TextStyle(
                                    //       fontSize: 18, fontWeight: FontWeight.bold),

                                    "Floor number :${myOrder.floorNumber}",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /3,
                                  ),
                                  // Text(
                                  //   // "Order id: ${myOrder.orderId}",
                                  //   // overflow: TextOverflow.ellipsis,
                                  //   // style: GoogleFonts.raleway(
                                  //   //   textStyle: const TextStyle(
                                  //   //       fontSize: 18, fontWeight: FontWeight.bold),
                                  //   "Street Name:",
                                  //   style: TextStyle(
                                  //     fontStyle: FontStyle.italic,
                                  //     fontSize: 15,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 60,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              // "Order id: ${myOrder.orderId}",
                              // overflow: TextOverflow.ellipsis,
                              // style: GoogleFonts.raleway(
                              //   textStyle: const TextStyle(
                              //       fontSize: 18, fontWeight: FontWeight.bold),

                              "Products :",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //   height: MediaQuery.of(context).size.height / 7,
                        //   width: MediaQuery.of(context).size.width - 10,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(10),
                            //color: Color(0xffFFF5EE),
                         // ),
                           ListView.builder(
                             // physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    elevation: 10,
                                    color:  Color(0xffFFF5EE),
                                    borderRadius: BorderRadius.circular(20),
                                    shadowColor: Color(0xffFFF5EE),
                                    child: Row(
                                      children: [
                                        Column(
                                            //mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width / 2.3,
                                                height: MediaQuery.of(context).size.height/17,
                                                // color:Colors.red,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Text(
                                                        // "Order id: ${myOrder.orderId}",
                                                        // overflow: TextOverflow.ellipsis,
                                                        // style: GoogleFonts.raleway(
                                                        //   textStyle: const TextStyle(
                                                        //       fontSize: 18, fontWeight: FontWeight.bold),

                                                        " Furniture Name : ",
                                                        style: TextStyle(
                                                           // fontFamily: "Montserrat",
                                                            fontSize: 15,
                                                            fontStyle: FontStyle.italic,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width /6.5,
                                                    ),
                                                    //Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Text(
                                                        // "Order id: ${myOrder.orderId}",
                                                        // overflow: TextOverflow.ellipsis,
                                                        // style: GoogleFonts.raleway(
                                                        //   textStyle: const TextStyle(
                                                        //       fontSize: 18, fontWeight: FontWeight.bold),
                                                        " Color :",
                                                        style: TextStyle(
                                                          //  fontFamily: "Montserrat",
                                                            fontSize: 15,
                                                            fontStyle: FontStyle.italic,
                                                           fontWeight: FontWeight.bold,)
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width / 2.3,
                                                height: MediaQuery.of(context).size.height / 9,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Text(
                                                        // "Order id: ${myOrder.orderId}",
                                                        // overflow: TextOverflow.ellipsis,
                                                        // style: GoogleFonts.raleway(
                                                        //   textStyle: const TextStyle(
                                                        //       fontSize: 18, fontWeight: FontWeight.bold),
                                                        " price : ",
                                                        style: TextStyle(
                                                            //fontFamily: "Montserrat",
                                                            fontSize: 15,
                                                            fontStyle: FontStyle.italic,
                                                              fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width /5,
                                                    ),
                                                    //Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Text(
                                                        // "Order id: ${myOrder.orderId}",
                                                        // overflow: TextOverflow.ellipsis,
                                                        // style: GoogleFonts.raleway(
                                                        //   textStyle: const TextStyle(
                                                        //       fontSize: 18, fontWeight: FontWeight.bold),
                                                        " Quantity :",
                                                        style: TextStyle(
                                                            //fontFamily: "Montserrat",
                                                            fontSize: 15,
                                                            fontStyle: FontStyle.italic,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                        SizedBox(
                                          width:MediaQuery.of(context).size.width /20,
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 4,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 4,
                                            //child: Image.network(furniture[index]["image"]),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                       // )

                      ])),
                ),

            ),
          ]),
        ),
      ),
    ));
  }
}
