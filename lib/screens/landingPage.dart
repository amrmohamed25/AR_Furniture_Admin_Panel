import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/screens/NavBar.dart';
import 'package:flutter/material.dart';

List<Widget> body(double width, bool isWeb){
  return [Container(
    width: width,
    child: Padding(
      padding: isWeb? const EdgeInsets.symmetric(horizontal: 25, vertical: 100):const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Augmented Reality", style: TextStyle(color: Color(0xFF0E4732), fontWeight: FontWeight.bold, fontSize: 60.0,),),
          const Text("Furniture", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 60.0,),),
          const SizedBox(
            height: 20,
          ),
          const Text("Augmented Reality Furniture Admin Panel", style: TextStyle(fontSize: 16.0),),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: (){
            },
            child: const Text(
              "Login",
              style: TextStyle(
                color: backgroundColor,
                fontSize: 20,
              ),
            ),
          ),

        ],
      ),
    ),
  ),
  Image.asset(
  "assets/images/company1.png",
  width: width,
  )];
}

class LandingPage extends StatelessWidget {
  //const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            primaryColor.withOpacity(1),
            secondaryColor.withOpacity(0.6),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ClipPath(
          clipper: WaveClip(),
          child: Container(
            color: const Color(0xFFFFFFF0),
            child: Column(
              children: [
                NavBar(),
                LandingPageBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LandingPageBody extends StatelessWidget {
  //const LandingPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraints){
          if (constraints.maxWidth > 800){
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: body(constraints.biggest.width/2, true),
            );
          } else {
            return Column(
              children: body(constraints.biggest.width, false),
            );
          }
        },
      ),
    );
  }
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 100;
    final highPoint = size.height - 120;
    path.lineTo(0,
        size.height); //Make a line starting from top left of screen till down

    /// Adds a quadratic bezier segment that curves from the current
    /// point to the given point (x2,y2), using the control point
    /// (x1,y1).
    path.quadraticBezierTo(size.width / 5, highPoint, size.width / 3, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

