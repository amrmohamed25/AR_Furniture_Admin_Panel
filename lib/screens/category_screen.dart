import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen();
  @override
  State<CategoryScreen> createState() => CategoryStaScreenState();
}

class CategoryStaScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(50),
              height: MediaQuery.of(context).size.height / 4 ,
      width: 300,
      child: ListView.builder(
        itemCount: 10,
          scrollDirection: Axis.horizontal, itemBuilder: (context,index){
          return Container(
            width: MediaQuery.of(context).size.width / 3,
            // color: secondaryColor,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black26)],
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 3.1),
                color: secondaryColor),
            child: const Center(
                child: Text(
                  'Item 1',
                  style: TextStyle(fontSize: 18, color: primaryColor),
                )),
          );
      }),
    ),
          ],
        ));
  }
}
