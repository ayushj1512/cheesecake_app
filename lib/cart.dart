import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 180, 204, 1),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Your Cart",
                  style: GoogleFonts.anton(
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 200,
                      width: 180,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Lottie.asset("assets/Delivery Boy (1).json",
                              height: 140),
                          SizedBox(
                            height: 2,
                          ),
                          Center(
                            child: Text(
                              "Delivery",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 200,
                      width: 180,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Lottie.asset("assets/Restaurant Open.json",
                              height: 140),
                          SizedBox(
                            height: 2,
                          ),
                          Center(
                            child: Text(
                              "Pickup",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 360,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Icon(Icons.cookie_rounded),
              title: Text(
                "Catering",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 360,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Icon(Icons.card_giftcard_rounded),
              title: Text(
                "Digital Gift Card",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
