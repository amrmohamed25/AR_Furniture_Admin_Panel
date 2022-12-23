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
    List<Map<String, dynamic>> orderFurniture = [];
    double tax = 0;
    double estimatingTax = 0.14;
    double totalPrice = 0;
    double subTotalPrice = 0;
    myOrder.order.forEach((key, shared) {
      for (int j = 0; j < shared.length; j++) {
        Map<String, dynamic> furniture = {};
        print("lol");
        print(shared[j].image);
        furniture["image"] = shared[j].image;
        furniture["price"] = shared[j].price;
        furniture["quantity"] = shared[j].quantityCart;
        furniture["discount"] = shared[j].discount;
        furniture["colorName"] = shared[j].colorName;
        print(key.split("|")[1]);
        furniture["name"] = key.split("|")[1];
        orderFurniture.add(furniture);
        // quantity = json["quantity"];
        // discount = json["discount"];
        // // print(furniture.shared.first.colorName);
        // // print(furniture.shared.length);
        // orderFurniture.add(furniture);
      }


    });
    for (var singleFurn in orderFurniture) {
      if (double.parse(singleFurn["quantity"])!=0){
    subTotalPrice += double.parse(singleFurn["quantity"]) *
    ( double.parse(singleFurn["price"]) -
    (double.parse(singleFurn["discount"]) /
    100)*
    double.parse(singleFurn["price"] )
    );
    }
    }
    tax = subTotalPrice * estimatingTax;
    totalPrice = subTotalPrice + tax;

    return DashboardScreen(
      Responsive(
        mobile:Container(
          // height: MediaQuery
          //     .of(context)
          //   .size
          //   .height - 100,
          decoration: BoxDecoration(color: secondaryColor),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
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
                    child: Column(
                        children: [
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width - 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          //color: Color(0xffFFF5EE),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                                    Text(
                                      "User Name : ${myOrder.userName}",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,

                                    ),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Order time : ${myOrder.time.toDate().year.toString()}-${myOrder.time.toDate().month.toString()}-${myOrder.time.toDate().day.toString()}",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Area :${myOrder.area}",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Floor number :${myOrder.floorNumber}",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,
                                      ),
                                    ),


                            SizedBox(
                              height: 10,
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
                                  height: 10,
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
                                  height: 10,
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
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(

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
                      Container(
                        height: orderFurniture.length *
                            MediaQuery.of(context).size.height /
                            5.5,
                        width: MediaQuery.of(context).size.width - 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.grey[300]),
                        ),
                        child: ListView.builder(
                          //physics: NeverScrollableScrollPhysics(),

                            shrinkWrap: true,
                            itemCount: orderFurniture.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  elevation: 10,
                                  color: Color(0xffFFF5EE),
                                  borderRadius: BorderRadius.circular(20),
                                  shadowColor: Color(0xffFFF5EE),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            " Furniture Name :  ${orderFurniture[index]["name"]}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              // fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),

                                          SizedBox(
                                            height: 1,
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                " price : ",
                                                style: TextStyle(
                                                  //fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontStyle:
                                                    FontStyle.italic,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              ),
                                              Text(
                                                (double.parse(
                                                    orderFurniture[
                                                    index]
                                                    ["price"]))
                                                    .toStringAsFixed(
                                                    2) +
                                                    ' L.E',
                                                style: TextStyle(
                                                  decoration: double.parse(orderFurniture[
                                                  index][
                                                  "discount"]).toInt()!=
                                                      0
                                                      ? TextDecoration
                                                      .lineThrough
                                                      : null,
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              if(double.parse(orderFurniture[index]["discount"]).toInt()!=0)
                                                Text(
                                                  (double.parse(
                                                      orderFurniture[
                                                      index]
                                                      ["price"])-double.parse(
                                                      orderFurniture[
                                                      index]
                                                      ["price"])*double.parse(orderFurniture[index]["discount"])/100)
                                                      .toStringAsFixed(
                                                      2) +
                                                      ' L.E',
                                                  style: TextStyle(


                                                    fontSize: 15.0,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              // SizedBox(width: 10,),
                                              // if(orderFurniture[index]["discount"]!="0")
                                              //
                                              //   Text(
                                              //
                                              //     '${(double.parse(orderFurniture[index]["price"]) -( (double.parse(orderFurniture[index]["discount"])/100)*double.parse(orderFurniture[index]["price"]))).toStringAsFixed(2)} L.E',
                                              //     style: TextStyle(
                                              //       fontSize: 15.0,
                                              //       fontWeight: FontWeight.w600,
                                              //       color: Colors.black,
                                              //     ),
                                              //   ),

                                            ],
                                          ),

                                          Text(
                                              " Color :${orderFurniture[index]["colorName"]}",
                                              style: TextStyle(
                                                //  fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              )),

                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/5,
                                          ),
                                          Text(
                                            " Quantity :${orderFurniture[index]["quantity"]}",
                                            style: TextStyle(
                                              //fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 20,
                                      ),
                                      Expanded(
                                        flex: 10,
                                        child: Container(
                                          width:
                                          MediaQuery.of(context).size.width / 4,
                                          height:
                                          MediaQuery.of(context).size.height / 4,
                                          child: Image.network(
                                              orderFurniture[index]["image"],
                                          fit: BoxFit.contain,),

                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/5,
                        width: MediaQuery.of(context).size.width-50,
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
                                " Totalprice",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 16,
                                    // fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "(added 14% tax) :  ${totalPrice} L.E",
                                style: TextStyle(
                                  //fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  //fontWeight: FontWeight.bold,)
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),),
              ),
            ),
          ),
        ),

        desktop:
        Container(
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
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
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
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        "User Name : ${myOrder.userName}",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Order time : ${myOrder.time.toDate().year.toString()}-${myOrder.time.toDate().month.toString()}-${myOrder.time.toDate().day.toString()}",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Area :${myOrder.area}",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Floor number :${myOrder.floorNumber}",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ]),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mobile number :${myOrder.mobileNumber}",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Street Name : ${myOrder.streetName}",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Building Name : ${myOrder.buildingNumber}",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(

                              "Products :",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          height: orderFurniture.length *
                              MediaQuery.of(context).size.height /
                              5.5,
                          width: MediaQuery.of(context).size.width - 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.grey[300]),
                          ),
                          child: ListView.builder(
                            //physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: orderFurniture.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    elevation: 10,
                                    color: Color(0xffFFF5EE),
                                    borderRadius: BorderRadius.circular(20),
                                    shadowColor: Color(0xffFFF5EE),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width:
                                                MediaQuery.of(context).size.width /
                                                    2.3,
                                                height:
                                                MediaQuery.of(context).size.height /
                                                    8,
                                                // color:Colors.red,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(5.0),
                                                          child: Text(
                                                            " Furniture Name :  ${orderFurniture[index]["name"]}",
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              // fontFamily: "Montserrat",
                                                                fontSize: 15,
                                                                fontStyle: FontStyle.italic,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: MediaQuery.of(context).size.height/30,
                                                        ),

                                                        Row(
                                                            children: [
                                                              Text(
                                                                // "Order id: ${myOrder.orderId}",
                                                                // overflow: TextOverflow.ellipsis,
                                                                // style: GoogleFonts.raleway(
                                                                //   textStyle: const TextStyle(
                                                                //       fontSize: 18, fontWeight: FontWeight.bold),
                                                                " price : ",
                                                                style: TextStyle(
                                                                  //fontFamily: "Montserrat",
                                                                    fontSize: 15,
                                                                    fontStyle:
                                                                    FontStyle.italic,
                                                                    fontWeight:
                                                                    FontWeight.bold),
                                                              ),


                                                              Text(
                                                                (double.parse(
                                                                    orderFurniture[
                                                                    index]
                                                                    ["price"]))
                                                                    .toStringAsFixed(
                                                                    2) +
                                                                    ' L.E',
                                                                style: TextStyle(
                                                                  decoration: double.parse(orderFurniture[
                                                                  index][
                                                                  "discount"] ).toInt()!= 0
                                                                      ? TextDecoration
                                                                      .lineThrough
                                                                      : null,
                                                                  fontSize: 15.0,
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  color: Colors.black,
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              if(double.parse(orderFurniture[index]["discount"]).toInt()!=0)

                                                                Text(

                                                                  '${(double.parse(orderFurniture[index]["price"]) -( (double.parse(orderFurniture[index]["discount"])/100)*double.parse(orderFurniture[index]["price"]))).toStringAsFixed(2)} L.E',
                                                                  style: TextStyle(
                                                                    fontSize: 15.0,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                            ]),
                                                      ],
                                                    ),

                                                    SizedBox(width: 40,),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(5.0),
                                                          child: Text(
                                                              " Color :${orderFurniture[index]["colorName"]}",
                                                              style: TextStyle(
                                                                //  fontFamily: "Montserrat",
                                                                fontSize: 15,
                                                                fontStyle: FontStyle.italic,
                                                                fontWeight: FontWeight.bold,
                                                              )),
                                                        ),

                                                        SizedBox(
                                                          height: MediaQuery.of(context).size.height/50,
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(5.0),
                                                          child: Text(
                                                            " Quantity :${orderFurniture[index]["quantity"]}",
                                                            style: TextStyle(
                                                              //fontFamily: "Montserrat",
                                                                fontSize: 15,
                                                                fontStyle: FontStyle.italic,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                        // SizedBox(
                                        //   width: MediaQuery.of(context).size.width / 20,
                                        // ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width:
                                            MediaQuery.of(context).size.width / 4,
                                            height:
                                            MediaQuery.of(context).size.height / 4,
                                            child: Image.network(
                                                orderFurniture[index]["image"]
                                              ,fit: BoxFit.contain,),
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Container(
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
                                  " Totalprice",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 18,
                                      // fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  // "Order id: ${myOrder.orderId}",
                                  // overflow: TextOverflow.ellipsis,
                                  // style: GoogleFonts.raleway(
                                  //   textStyle: const TextStyle(
                                  //       fontSize: 18, fontWeight: FontWeight.bold),
                                  "(added 14% tax) :  ${totalPrice} L.E",
                                  style: TextStyle(
                                    //fontFamily: "Montserrat",
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    //fontWeight: FontWeight.bold,)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ])),
                ),
              ),
            ]
            ),
          ),
        ),
    ));
  }
}
