import 'package:flutter/material.dart';

import '../constants.dart';

class DashboardScreen extends StatefulWidget {
  @override
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}
class _DashboardScreen extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: Row(
          children: [
            Expanded(
              flex:2,
              child: Container(
                  color: secondaryColor,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            DrawerHeader(child:FlutterLogo(
                              size: 20,

                            ),),
                            Text(
                              "Furniture",
                              style: TextStyle(color:Colors.black,fontSize: 20),

                            ),

                          ]),
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
              flex:5,
              child: Container(
                color: backgroundColor,
              ),
            ),
          ],
        ),
      ),

    );
  }
}