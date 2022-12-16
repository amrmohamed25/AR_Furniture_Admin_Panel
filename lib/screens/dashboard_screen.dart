import 'package:ar_furniture_admin_panel/responsive.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DashboardScreen extends StatefulWidget {
  // @override
  // Widget orderscreen;
  //  DashboardScreen(this.orderscreen);

  @override
  Widget FurnitureScreen;
  DashboardScreen(this.FurnitureScreen);

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}
class _DashboardScreen extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return
      Responsive(mobile:
         Scaffold(
           key: scaffoldKey,
           drawer:  Container(
             width:MediaQuery.of(context).size.width*0.4,
               color: secondaryColor,
               child: Column(
                 children: [
                   DrawerHeader(child:Row(
                     children: [
                       FlutterLogo(
                         size: 18,
                       ),
                       SizedBox(width: 20,),
                       Text(
                         "Admin Dashboard",
                         style: TextStyle(color:Colors.black,fontSize: 13,fontWeight: FontWeight.bold),
                         textAlign: TextAlign.start,

                       ),
                       Row()
                     ],
                   ),),
                   ListTile(
                     onTap: (){},
                     horizontalTitleGap: 0.0,
                     leading: Icon(
                       Icons.dashboard,
                       color: Colors.black,
                       size: 10,

                     ),
                     title: Text(
                       "Dashboard",
                       style: TextStyle(color:Colors.black,fontSize: 12),

                     ),
                   ),
                   ListTile(
                     onTap: (){},
                     horizontalTitleGap: 0.0,
                     leading: Icon(
                       Icons.category,
                       color: Colors.black,
                       size: 10,

                     ),
                     title: Text(
                       "Category",
                       style: TextStyle(color:Colors.black,fontSize: 12),
                     ),
                   ),
                   ListTile(
                     onTap: (){},
                     horizontalTitleGap: 0.0,
                     leading: Icon(
                       Icons.shopping_cart,
                       color: Colors.black,
                       size:12,

                     ),
                     title: Text(
                       "Orders",
                       style: TextStyle(color:Colors.black,fontSize: 12),
                     ),
                   ),
                 ],

               )
           ),
           appBar: AppBar(
             backgroundColor: secondaryColor,
             leading: IconButton(icon: Icon(Icons.menu),onPressed: (){
               scaffoldKey.currentState!.openDrawer();
             },),
           ),
           body: SafeArea(
             child: Row(
               children: [

                 Expanded(
                   flex:2,
                   child: Container(
                     color: backgroundColor,
                   ),
                 ),
               ],
             ),
           ),


         )
          , desktop:   Scaffold(
        body: SafeArea(

          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    color: secondaryColor,
                    child: Column(
                      children: [
                        DrawerHeader(child:Row(
                          children: [
                            FlutterLogo(
                              size: 18,
                            ),
                            SizedBox(width: 20,),
                            Text(
                              "Admin Dashboard",
                              style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,

                            ),
                            Row()
                          ],
                        ),),
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
                          onTap: (){},
                          horizontalTitleGap: 0.0,
                          leading: Icon(
                            Icons.dashboard,
                            color: Colors.black,

                          ),
                          title: Text(
                            "Dashboard",
                            style: TextStyle(color:Colors.black,fontSize: 15),

                          ),
                        ),
                        ListTile(
                          onTap: (){},
                          horizontalTitleGap: 0.0,
                          leading: Icon(
                            Icons.category,
                            color: Colors.black,

                          ),
                          title: Text(
                            "Category",
                            style: TextStyle(color:Colors.black,fontSize: 15),
                          ),
                        ),
                        ListTile(
                          onTap: (){},
                          horizontalTitleGap: 0.0,
                          leading: Icon(
                            Icons.shopping_cart,
                            color: Colors.black,

                          ),
                          title: Text(
                            "Orders",
                            style: TextStyle(color:Colors.black,fontSize: 15),
                          ),
                        ),
                      ],

                    )
                ),
              ),
              Expanded(
                flex:6,
                child: Container(
                  //color: backgroundColor,
                  // child: widget.orderscreen
                  child: widget.FurnitureScreen,


                ),
             ),
            ],
          ),
        ),

      ))
    ;
  }
}