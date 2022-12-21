import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/furniture_model.dart';

class ViewFurnitureScreen extends StatefulWidget {
  FurnitureModel selectedFurniture;
  List<Color?> availableColors;

  ViewFurnitureScreen(
      {required this.selectedFurniture, required this.availableColors});

  @override
  State<ViewFurnitureScreen> createState() => _ViewFurnitureScreenState();
}

class _ViewFurnitureScreenState extends State<ViewFurnitureScreen> {

  List<DataRow> rows = [];
  int selectedColorIndex = 0;

  // Color? selectedColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeTable();
  }

  void initializeTable() async {
    await createTable();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("Building");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
          Positioned(
          top:-150,
          right: -150,
          child: CustomCircleAvatar(
            radius: 200,
            CavatarColor: primaryColor,
          ),
          ),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 300,
                      width: 300,
                      child: Image.network(
                        widget.selectedFurniture.shared[selectedColorIndex].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 50,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.availableColors.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedColorIndex = index;
                                  // selectedColor = widget.availableColors[index];
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                child: CustomCircleAvatar(
                                  radius: 20.0,
                                  // MediaQuery
                                  //     .of(context)
                                  //     .size
                                  //     .height > 700
                                  //     ? 15.0
                                  //     : 12.0,
                                  CavatarColor: widget.availableColors[index],
                                  icon: index == selectedColorIndex
                                      ? Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 25.0,
                                    // MediaQuery
                                    //     .of(context)
                                    //     .size
                                    //     .height >
                                    //     700
                                    //     ? 22.0
                                    //     : 18.0,
                                  )
                                      : null,
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 40.0,),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: thirdColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 10.0,),
                          Text("Edit"),
                        ],
                      ),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.selectedFurniture.name,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.selectedFurniture.description == null ? SizedBox(
                      height: 10.0,) : Text(
                      widget.selectedFurniture.description!,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: ReusableCard(
                                  onPress: () {
                                    // setState(() {
                                    //   selectedGender = Gender.male;
                                    // });
                                  },
                                  color: secondaryColor,
                                  cardChild: IconContent(
                                    icon: FontAwesomeIcons.dollarSign,
                                    label: 'Price',
                                    value: widget.selectedFurniture
                                        .shared[selectedColorIndex].price,
                                    discount: widget.selectedFurniture
                                        .shared[selectedColorIndex].discount,
                                  ),
                                )),
                            Expanded(
                                child: ReusableCard(
                                  onPress: () {
                                    // setState(() {
                                    //   selectedGender = Gender.male;
                                    // });
                                  },
                                  color: secondaryColor,
                                  cardChild: IconContent(
                                    icon: Icons.percent,
                                    label: 'Offer',
                                    value: double.parse(widget.selectedFurniture
                                        .shared[selectedColorIndex].discount)
                                        .toInt()
                                        .toString(),
                                    discount: widget.selectedFurniture
                                        .shared[selectedColorIndex].discount,
                                  ),
                                )),
                            Spacer(),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ReusableCard(
                                  onPress: () {
                                    // setState(() {
                                    //   selectedGender = Gender.male;
                                    // });
                                  },
                                  color: secondaryColor,
                                  cardChild: IconContent(
                                    icon: Icons.star,
                                    label: 'Average Rating',
                                    value: widget.selectedFurniture
                                        .calculateAverageRating().toString(),
                                    discount: widget.selectedFurniture
                                        .shared[selectedColorIndex].discount,
                                  ),
                                )),
                            Expanded(
                                child: ReusableCard(
                                  onPress: () {
                                    // setState(() {
                                    //   selectedGender = Gender.male;
                                    // });
                                  },
                                  color: secondaryColor,
                                  cardChild: IconContent(
                                    icon: FontAwesomeIcons.hashtag,
                                    label: 'Available Quantity',
                                    value: widget.selectedFurniture
                                        .shared[selectedColorIndex].quantity,
                                    discount: widget.selectedFurniture
                                        .shared[selectedColorIndex].discount,
                                  ),
                                )),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    rows.length == 0 ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(color: thirdColor,),
                    ) : DataTable(
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Name',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Rating',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                      rows: rows,
                      //   DataRow(
                      //     cells: <DataCell>[
                      //       DataCell(Text('Fady')),
                      //       DataCell(
                      //         RatingBar.builder(
                      //           itemSize: 20.0,
                      //           initialRating: widget.selectedFurniture.calculateAverageRating(),
                      //           //minRating: 1,
                      //           direction: Axis.horizontal,
                      //           // allowHalfRating: true,
                      //           ignoreGestures: true,
                      //           itemCount: 5,
                      //           itemPadding: const EdgeInsets.symmetric(
                      //               horizontal: 1.0),
                      //           itemBuilder: (context, _) =>
                      //           const Icon(
                      //             Icons.star,
                      //             color: Colors.amber,
                      //           ),
                      //           onRatingUpdate: (rating) {
                      //             //   print("Rating: " + rating.toString());
                      //             //   setState(() {
                      //             //     starsRating = rating;
                      //             //   });
                      //           },
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   DataRow(
                      //     cells: <DataCell>[
                      //       DataCell(Text('Janine')),
                      //       DataCell(Text('43')),
                      //     ],
                      //   ),
                      //   DataRow(
                      //     cells: <DataCell>[
                      //       DataCell(Text('William')),
                      //       DataCell(Text('27')),
                      //     ],
                      //   ),
                      // ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createTable() async {
    for (var entry in widget.selectedFurniture.ratings.entries) {
      await FirebaseFirestore.instance.collection("user").doc(entry.key)
          .get()
          .then((document) {
        String userName = document.data()!['fName'] + " " +
            document.data()!['lName'];

        rows.add(
          DataRow(
            cells: <DataCell>[
              DataCell(Text(userName)),
              DataCell(
                RatingBar.builder(
                  itemSize: 20.0,
                  initialRating: entry.value,
                  //minRating: 1,
                  direction: Axis.horizontal,
                  // allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(
                      horizontal: 1.0),
                  itemBuilder: (context, _) =>
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
            ],
          ),
        );
      }).catchError((error) =>
          print("Error in ratings table" + error.toString()));
    }
  }
}

class ReusableCard extends StatelessWidget {
  // Custom Widget

  final Color color; // const can't be used at run time so, we use final
  final Widget? cardChild;
  final VoidCallback? onPress;

  ReusableCard({required this.color, this.cardChild, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(right: 15.0, top: 15.0, bottom: 15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: cardChild,
      ),
    );
  }
}

class IconContent extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final String? value;
  final String? discount;

  IconContent({this.icon, this.label, this.value, this.discount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80.0,
          ),
          SizedBox(
            width: 15.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label!,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  label != "Price" ?
                  Text(
                    label == "Offer" ? value! + " %" : label == "Average Rating"
                        ? value! + ".0"
                        : value!,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.0,
                    ),
                  ) : discount != "0.0" ? Text(
                    value! + " L.E",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: primaryColor,
                      fontSize: 18.0,
                    ),
                  ) : Text(""),
                  SizedBox(width: 10.0,),
                  label == "Price" ? (discount != "0" ? Text(
                    (double.parse(value!) -
                        double.parse(discount!) / 100 * double.parse(value!))
                        .toString() + " L.E",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.0,
                    ),
                  ) : Text("")) : Text(""),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class CustomCircleAvatar extends StatelessWidget {
  double? radius;
  Color? CavatarColor;
  Icon? icon;

  CustomCircleAvatar(
      {required this.radius, required this.CavatarColor, this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: CavatarColor,
      child: icon,
    );
  }
}

// Card(
// child: Container(
// height: 290,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20)),
// margin: EdgeInsets.all(5),
// padding: EdgeInsets.all(5),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// Expanded(
// child: Image.network(
// 'https://tech.pelmorex.com/wp-content/uploads/2020/10/flutter.png',
// fit: BoxFit.fill,
// ),
// ),
// Text(
// 'Title',
// style: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.bold,
// ),
// ),
// Text(
// 'Subtitle',
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 15,
// ),
// )
// ],
// ),
// ),
// );
