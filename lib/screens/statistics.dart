import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/models/statistics_model.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../cubits/admin_cubit.dart';
import '../cubits/admin_states.dart';

class StatisticScreen extends StatefulWidget {
  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  List<String> yearsList = <String>['2020', '2021', '2022', '2023'];
  List<Statistics> yearStats = [];
  String dropdownValue = "";
  late List<_ChartData> data = [];
  late TooltipBehavior _tooltip;

  // Map<String, dynamic> monthlyOrders = {
  //   "Jan": 0,
  //   "Feb": 5,
  //   "Mar": 0,
  //   "Apr": 0,
  //   "May": 0,
  //   "Jun": 0,
  //   "Jul": 0,
  //   "Aug": 0,
  //   "Sep": 0,
  //   "Oct": 0,
  //   "Nov": 0,
  //   "Dec": 0
  // };

  // String totalNumberOfOrders = "50";
  // String totalIncome = "1250";

  List<String> categories = ["Beds", "Chairs", "Sofas", "Tables"];
  Map<String, dynamic> categoriesIncome = {
    "Beds": "8",
    "Chairs": "30",
    "Sofas": "15",
    "Tables": "12"
  };

  // double maxMonthlyOrders = 0;
  double maxIncome = 0;

  // StatisticScreen({required this.monthlyOrders, required this.totalNumberOfOrders, required this.totalIncome});

  @override
  void initState() {
    dropdownValue = yearsList.first;

    // monthlyOrders.forEach((key, value) {
    //   if (value > maxMonthlyOrders) {
    //     maxMonthlyOrders = value;
    //   }
    // });

    for (int i = 0; i < categories.length; i++) {
      if (double.parse(categoriesIncome[categories[i]]) > maxIncome) {
        maxIncome = double.parse(categoriesIncome[categories[i]]);
      }
    }

    for (int i = 0; i < categories.length; i++) {
      data.add(_ChartData(
          categories[i], double.parse(categoriesIncome[categories[i]])));
    }

    // data = [
    //   _ChartData('Beds', 12),
    //   _ChartData('Chairs', 15),
    //   _ChartData('Sofas', 30),
    //   _ChartData('Tables', 6.4),
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print("Statssssssss");
          print(state);
          print(BlocProvider.of<AdminCubit>(context).monthlyOrders.keys);
          print(BlocProvider.of<AdminCubit>(context).monthlyOrders.values);
          return state is LoadedAllData ? DashboardScreen(
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 12,
                  //margin: const EdgeInsets.all(5),
                  child: const Text(
                    'Statistics',
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) async {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                      yearStats = await BlocProvider.of<AdminCubit>(context).getStatisticsByYear(dropdownValue);
                    },
                    items:
                        yearsList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.yellow.shade200,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Number of Orders",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 20.0),
                                child: BarChartDiagram(
                                  monthlyOrdersCount: BlocProvider.of<AdminCubit>(context).monthlyOrders,
                                  maxOrdersCount: BlocProvider.of<AdminCubit>(context).maxMonthlyOrders,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade200,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.numbers),
                                          Text(
                                            "Total number of orders",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        BlocProvider.of<AdminCubit>(context).totalOrders.toString(),
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade200,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(FontAwesomeIcons.dollarSign),
                                          Text(
                                            "Total Income",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        BlocProvider.of<AdminCubit>(context).totalIncome.toString(),
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded(child: _BarChart()),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.yellow.shade200,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Center(
                                    child: Text(
                                      "Ordered items count from each category",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Expanded(
                                      child: PieChartSample2(
                                    categories: categories,
                                  )),
                                ],
                              ))),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.yellow.shade200,
                        ),
                        child: SfCartesianChart(
                            title: ChartTitle(text: "Income Graph"),
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(
                                minimum: 0,
                                maximum: maxIncome + 10,
                                interval: 10),
                            tooltipBehavior: _tooltip,
                            series: <ChartSeries<_ChartData, String>>[
                              BarSeries<_ChartData, String>(
                                dataSource: data,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                name: 'Income',
                                // color: Colors.orange,
                                gradient: LinearGradient(colors: [
                                  Colors.red,
                                  Colors.orange,
                                  Colors.yellowAccent
                                ]),
                              )
                            ]),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ) : Center(child: CircularProgressIndicator(),);
        });
  }
}

// Bar Chart
class BarChartDiagram extends StatelessWidget {
  Map<String, dynamic> monthlyOrdersCount = {};
  double maxOrdersCount;

  BarChartDiagram(
      {required this.monthlyOrdersCount, required this.maxOrdersCount});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxOrdersCount + 1,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [Colors.red, Colors.orange, Colors.yellow],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['Jan'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: double.parse(monthlyOrdersCount['Feb']),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['Mar'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['Apr'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['May'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['Jun'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['Jul'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['Aug'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['Sep'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['Oct'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['Nov'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              toY: monthlyOrdersCount['Dec'],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

// class BarChartSample3 extends StatefulWidget {
//   const BarChartSample3({super.key});
//
//   @override
//   State<StatefulWidget> createState() => BarChartSample3State();
// }
//
// class BarChartSample3State extends State<BarChartSample3> {
//   @override
//   Widget build(BuildContext context) {
//     return const AspectRatio(
//       aspectRatio: 1.6,
//       child: BarChartDiagram(),
//     );
//   }
// }

// Pie Chart
class PieChartSample2 extends StatefulWidget {
  List<String> categories = [];

  PieChartSample2({required this.categories});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  List<Color> colors = [
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.grey,
    Colors.black,
    Colors.indigo,
    Colors.brown
  ];
  Map<String, dynamic> categoriesOrders = {
    "Beds": "40",
    "Chairs": "30",
    "Sofas": "15",
    "Tables": "15"
  };

  List<Widget> getPieChartCategories() {
    List<Widget> indicatorWidgets =
        List<Widget>.generate(widget.categories.length, (int index) {
      return Indicator(
          color: colors[index], text: widget.categories[index], isSquare: true);
    });
    indicatorWidgets.add(SizedBox(
      height: 14,
    ));
    return indicatorWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getPieChartCategories(),
            // Indicator(
            //   color: Colors.blue,
            //   text: 'Beds',
            //   isSquare: true,
            // ),
            // SizedBox(
            //   height: 4,
            // ),
            // Indicator(
            //   color: Colors.yellow,
            //   text: 'Chairs',
            //   isSquare: true,
            // ),
            // SizedBox(
            //   height: 4,
            // ),
            // Indicator(
            //   color: Colors.purple,
            //   text: 'Sofas',
            //   isSquare: true,
            // ),
            // SizedBox(
            //   height: 4,
            // ),
            // Indicator(
            //   color: Colors.green,
            //   text: 'Tables',
            //   isSquare: true,
            // ),
            // SizedBox(
            //   height: 18,
            // ),
            // ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.categories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: colors[i],
        value: double.parse(categoriesOrders[widget.categories[i]]),
        title: categoriesOrders[widget.categories[i]] + "%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
      // switch (i) {
      //   case 0:
      //     return PieChartSectionData(
      //       color: colors[i],
      //       value: 40,
      //       title: '40%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //         shadows: shadows,
      //       ),
      //     );
      //   case 1:
      //     return PieChartSectionData(
      //       color: Colors.yellow,
      //       value: 30,
      //       title: '30%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //         shadows: shadows,
      //       ),
      //     );
      //   case 2:
      //     return PieChartSectionData(
      //       color: Colors.purple,
      //       value: 15,
      //       title: '15%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //         shadows: shadows,
      //       ),
      //     );
      //   case 3:
      //     return PieChartSectionData(
      //       color: Colors.green,
      //       value: 15,
      //       title: '15%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //         shadows: shadows,
      //       ),
      //     );
      //   default:
      //     throw Error();
      // }
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                color: color,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            )
          ],
        ),
        SizedBox(
          height: 4,
        )
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

// class ReusableCard extends StatelessWidget {
//   // Custom Widget
//
//   final Color color; // const can't be used at run time so, we use final
//   final Widget? cardChild;
//   final VoidCallback? onPress;
//
//   ReusableCard({required this.color, this.cardChild, this.onPress});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPress,
//       child: Container(
//         margin: EdgeInsets.all(15.0),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: cardChild,
//       ),
//     );
//   }
// }
