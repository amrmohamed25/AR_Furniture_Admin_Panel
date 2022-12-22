import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:ar_furniture_admin_panel/screens/edit_furniture_screen.dart';
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
    print("Width " + MediaQuery.of(context).size.width.toString() + " / Height: " + (MediaQuery.of(context).size.height * 0.5).toString());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
          Positioned(
          top: MediaQuery
              .of(context)
              .size
              .width >= 850 ? -MediaQuery.of(context).size.width * 0.15: -MediaQuery
              .of(context)
              .size
              .width * 0.33,
          right: MediaQuery
              .of(context)
              .size
              .width >= 850 ? -MediaQuery.of(context).size.width * 0.11: -MediaQuery
              .of(context)
              .size
              .width * 0.26,
          child: CustomCircleAvatar(
            radius: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.15 : MediaQuery.of(context).size.width * 0.25,
            CavatarColor: primaryColor,
          ),
          ),
              Positioned(
                top: 0,
                right: 5.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.25,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.25,
                      child: Image.network(
                        widget.selectedFurniture.shared[selectedColorIndex].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.03 : MediaQuery.of(context).size.width * 0.05,
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
                                padding: MediaQuery.of(context).size.width >= 850 ? const EdgeInsets.only(
                                    left: 5.0, right: 4.0) : const EdgeInsets.only(
                                    left: 2.0, right: 1.0),
                                child: CustomCircleAvatar(
                                  radius: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.014 : MediaQuery.of(context).size.width * 0.03,
                                  CavatarColor: widget.availableColors[index],
                                  icon: index == selectedColorIndex
                                      ? Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.017 : MediaQuery.of(context).size.width * 0.032,
                                  )
                                      : null,
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 50.0,),
                    Container(
                      height: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.04 : MediaQuery.of(context).size.width * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(EditFurnitureScreen(widget.selectedFurniture))));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: thirdColor,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit, size: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.018 : MediaQuery.of(context).size.width * 0.027,),
                            SizedBox(width: 10.0,),
                            Text("Edit", style: TextStyle(fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.012 : MediaQuery.of(context).size.width * 0.02,),),
                          ],
                        ),),
                    ),
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
                        fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.028 : MediaQuery.of(context).size.width * 0.033,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.selectedFurniture.description == null ? SizedBox(
                      height: 10.0,) : Text(
                      widget.selectedFurniture.description!,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.023 : MediaQuery.of(context).size.width * 0.028,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: ReusableCard(
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
                                  color: secondaryColor,
                                  cardChild: IconContent(
                                    icon: Icons.percent,
                                    label: 'Sale',
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
                    SizedBox(height: MediaQuery.of(context).size.width >= 850 ? 35.0: 25.0,),
                    Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.02 : MediaQuery.of(context).size.width * 0.033,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width >= 850 ? 20.0 : 15.0,),
                    rows.length == 0 ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(color: thirdColor,),
                    ) : DataTable(
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      columns: <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Name',
                              style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.012 : MediaQuery.of(context).size.width * 0.023),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Rating',
                              style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.012 : MediaQuery.of(context).size.width * 0.023),
                            ),
                          ),
                        ),
                      ],
                      rows: rows,
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
              DataCell(Text(userName, style: TextStyle(fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.012 : MediaQuery.of(context).size.width * 0.023),)),
              DataCell(
                RatingBar.builder(
                  itemSize: MediaQuery.of(context).size.width >= 850 ? 20.0: 10.0,
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

  ReusableCard({required this.color, this.cardChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15.0, top: 15.0, bottom: 15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: cardChild,
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
            size: MediaQuery.of(context).size.width * 0.05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width >= 850 ? 20.0 : 10.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label!,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.013 : MediaQuery.of(context).size.width * 0.019,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width >= 850 ? 15.0 : 8.0,
              ),
              Row(
                children: [
                  label != "Price" ?
                  Text(
                    label == "Sale" ? value! + " %" : label == "Average Rating"
                        ? value! + ".0"
                        : value!,
                    style: TextStyle(
                      color: primaryColor,
                        fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.018 : MediaQuery.of(context).size.width * 0.03,
                        fontWeight: FontWeight.bold,
                    ),
                  ) : discount != "0.0" ? Text(
                    value! + " L.E",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red,
                      fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.018 : 10.0,
                    ),
                  ) : Text(""),
                  SizedBox(width: 10.0,),
                  label == "Price" ? (discount != "0" ? Text(
                    (double.parse(value!) -
                        double.parse(discount!) / 100 * double.parse(value!))
                        .toString() + " L.E",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: MediaQuery.of(context).size.width >= 850 ? MediaQuery.of(context).size.width * 0.018 : 10.0,
                      fontWeight: FontWeight.bold,
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
