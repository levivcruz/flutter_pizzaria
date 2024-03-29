import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'models/pizza.dart';

class Details extends StatelessWidget {
  Details(this.pizzaObject);

  final Pizza pizzaObject;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(pizzaObject.background);
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                BackgroundArc(pizzaObject.background),
                ForegroundContent(pizzaObject: pizzaObject)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ForegroundContent extends StatelessWidget {
  const ForegroundContent({@required this.pizzaObject});

  final Pizza pizzaObject;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 70, left: 50),
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, size: 30),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          PizzaImage(pizzaObject.image),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(pizzaObject.name),
                SizedBox(height: 20),
                CategoriaParasita(pizzaObject.categoria),
                SizedBox(height: 20),
                Description(pizzaObject.desc),
                SizedBox(height: 20),
                Price(pizzaObject.price),
                SizedBox(height: 20),
                SizedBox(height: 35),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Price extends StatelessWidget {
  final double price;

  const Price(this.price);

  @override
  Widget build(BuildContext context) {
    return Text(
      "\$$price",
      style: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
    );
  }
}

class Description extends StatelessWidget {
  final String desc;

  const Description(this.desc);

  @override
  Widget build(BuildContext context) {
    return Text(
      desc,
      softWrap: true,
      style: TextStyle(
          color: Colors.black87,
          letterSpacing: 1.3,
          fontSize: 17,
          textBaseline: TextBaseline.alphabetic),
    );
  }
}

class CategoriaParasita extends StatelessWidget {
  final String categoria;

  const CategoriaParasita(this.categoria);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(categoria.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow[600],
          size: 25,
        )
      ],
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText(this.pizzaName);

  final String pizzaName;
  final double _fontSize = 40;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: pizzaName,
            style: TextStyle(
              color: Colors.black,
              fontSize: _fontSize,
              fontFamily: "slabo",
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class PizzaImage extends StatelessWidget {
  final String imageURI;

  const PizzaImage(this.imageURI);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Image.asset(imageURI),
    );
  }
}

class BackgroundArc extends StatelessWidget {
  const BackgroundArc(this.background);

  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: BackgroundPainter(background),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  BackgroundPainter(this.color);

  final Color color;

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint painter = Paint()..color = color;
    path.moveTo(250, 0);

    /*
      these are very absolute coordinates, thus they are not efficient when you open the app in landscape mode.
      Try finding how you can make them relative to the screen.
      Hint: You would have to use the size parameter which is being passed.
    */

    path.quadraticBezierTo(150, 125, 240, 270);
    path.quadraticBezierTo(300, 345, 450, 350);

    path.lineTo(500, 0);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
