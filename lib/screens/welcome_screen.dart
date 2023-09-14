import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../repository/drinks/drinks_repository.dart';
import '../repository/drinks/models/item.dart';
import 'drinks_catalog_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Item> _drinks = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final drinks = await DrinksRepository().getDrinks();
    setState(() {
      _drinks = drinks;
      print(_drinks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 100, bottom: 40),
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage('images/bg.png'),
              fit: BoxFit.cover,
              opacity: 0.6,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Coffee Shop",
              style: GoogleFonts.pacifico(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
            Column(
              children: [
                Text(
                  "Feeling Low? Take a Sip of Coffee",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                _drinks.isEmpty
                    ? CircularProgressIndicator()
                    :
                Material(
                        color: Color(0xFFE57734),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DrinksCatalogScreen(_drinks),
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 50),
                            decoration: BoxDecoration(),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
