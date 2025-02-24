import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  final List<Map<String, String>> offers = [
    {
      "title": "Flat 20% Off on First Order!",
      "image": "assets/carousel1.jpg",
      "description": "Get 20% off on your first order. Use code: WELCOME20",
      "validity": "Valid till 29th Feb 2025",
    },
    {
      "title": "Buy 1 Get 1 Free",
      "image":
          "assets/royalty-free-stock-photography-clip-art-offers-vector-thumbnail.jpg",
      "description": "Order any cheesecake and get another one for free!",
      "validity": "Valid till 10th March 2025",
    },
    {
      "title": "Free Delivery on Orders Above ₹499",
      "image":
          "assets/royalty-free-stock-photography-clip-art-offers-vector-thumbnail.jpg",
      "description": "Enjoy free delivery on all orders above ₹499.",
      "validity": "Limited Time Offer!",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 180, 204, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 180, 204, 1),
        centerTitle: true,
        title: Text(
          "exclusive offers",
          style: GoogleFonts.anton(fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Grab the Deals Now! 🎉",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final offer = offers[index];

                  return GestureDetector(
                    onTap: () {
                      // You can navigate to a detailed offer screen or perform an action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text("Offer: ${offer["title"]} selected!")),
                      );
                    },
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      shadowColor: Colors.pink.shade100,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                offer["image"]!,
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer["title"]!,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    offer["description"]!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade800),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    offer["validity"]!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
