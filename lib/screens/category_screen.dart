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
    return  Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height / 7,
          // width: MediaQuery.of(context).size.height / 1,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 3.2,
                  // color: secondaryColor,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 3, color: Colors.black26)
                      ],
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width / 3.1),
                      color: secondaryColor),
                  child: const Center(
                      child: Text(
                    'Item 1',
                    style: TextStyle(fontSize: 18, color: primaryColor),
                  )),
                );
              }),
        ),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 90),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
            ),
            ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width / 3.2,
                    // color: secondaryColor,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 3, color: Colors.black26)
                        ],
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width / 3.1),
                        color: secondaryColor),
                  //   child: const Center(
                  //       children:[]
                  // );
                }),


          ],



        )

      ],
    );
  }
}
