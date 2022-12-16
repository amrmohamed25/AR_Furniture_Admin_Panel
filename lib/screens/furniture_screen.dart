import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/responsive.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class FurnitureScreen extends StatefulWidget {
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
        // Column(
        //   children: [
        //     Container(
        //       margin: EdgeInsets.all(10),
        //       height: MediaQuery.of(context).size.height / 7,
        //       // width: MediaQuery.of(context).size.height / 1,
        //       child: ListView.builder(
        //           itemCount: 10,
        //           scrollDirection: Axis.horizontal,
        //           itemBuilder: (context, index) {
        //             return Container(
        //               margin: EdgeInsets.all(10),
        //               width: MediaQuery.of(context).size.width / 3.2,
        //               // color: secondaryColor,
        //               decoration: BoxDecoration(
        //                   boxShadow: [
        //                     BoxShadow(blurRadius: 3, color: Colors.black26)
        //                   ],
        //                   borderRadius: BorderRadius.circular(
        //                       MediaQuery.of(context).size.width / 3.1),
        //                   color: secondaryColor),
        //               child: const Center(
        //                   child: Text(
        //                 'Item 1',
        //                 style: TextStyle(fontSize: 18, color: primaryColor),
        //               )),
        //             );
        //           }),
        //     ),
        //     Stack(
        //       children: [
        //         Container(
        //           margin: EdgeInsets.only(top: 90),
        //           decoration: BoxDecoration(
        //             color: Colors.grey,
        //             borderRadius: BorderRadius.only(
        //               topRight: Radius.circular(20.0),
        //               topLeft: Radius.circular(20.0),
        //             ),
        //           ),
        //         ),
        //         ListView.builder(
        //             itemCount: 10,
        //             scrollDirection: Axis.horizontal,
        //             itemBuilder: (context, index) {
        //               return Container(
        //                 margin: EdgeInsets.all(10),
        //                 width: MediaQuery.of(context).size.width / 3.2,
        //                 // color: secondaryColor,
        //                 decoration: BoxDecoration(
        //                     boxShadow: [
        //                       BoxShadow(blurRadius: 3, color: Colors.black26)
        //                     ],
        //                     borderRadius: BorderRadius.circular(
        //                         MediaQuery.of(context).size.width / 3.1),
        //                     color: secondaryColor),
        //
        //                 child: const Center(
        //                     child: Text(
        //                   'Item 1',
        //                   style: TextStyle(fontSize: 18, color: primaryColor),
        //                 )),
        //               );
        //             }),
        //       ],
        //     )
        //   ],
        // ),
        Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15.0),
          height:Responsive(mobile: MediaQuery.of(context).size.height * 0.15,desktop: MediaQuery.of(context).size.height * 0.175);



      )],
    ));
  }
}
