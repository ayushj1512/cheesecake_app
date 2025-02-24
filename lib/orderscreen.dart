import 'package:flutter/material.dart';
import 'package:funkypanda/cart2.dart';
import 'package:funkypanda/cart3.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int cartCount = 0;
  List<Map<String, dynamic>> cartItems = [];

  List<Map<String, dynamic>> cheesecakes = [
    {
      "name": "Classic\nCheesecake",
      "price": 299,
      "image": "assets/inspiration2.png"
    },
    {
      "name": "Blueberry\nCheesecake",
      "price": 349,
      "image": "assets/inspiration2.png"
    },
    {
      "name": "Strawberry\nCheesecake",
      "price": 329,
      "image": "assets/inspiration2.png"
    },
    {
      "name": "Chocolate\nCheesecake",
      "price": 379,
      "image": "assets/inspiration2.png"
    },
  ];

  void addToCart(Map<String, dynamic> cheesecake) {
    setState(() {
      cartItems.add(cheesecake);
      cartCount = cartItems.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 180, 204, 1),
        elevation: 0,
        title: Text(
          "start an order",
          style: GoogleFonts.anton(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cart3(
                        cartItems: cartItems, // Pass the actual cartItems list
                      ),
                    ),
                  );
                },
              ),
              if (cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Text(
                      '$cartCount',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "Good Food" text container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Container(
                    padding:
                        EdgeInsets.all(12), // Added padding for better spacing
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 180, 204, 1),
                    ),
                    child: Text(
                      "Good food, great moments! Checkout our menu and find your perfect meal",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Cheesecake GridView
              GridView.builder(
                itemCount: cheesecakes.length,
                shrinkWrap: true, // Ensures it takes only needed space
                physics:
                    NeverScrollableScrollPhysics(), // Disables GridView's scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.2,
                ),
                itemBuilder: (context, index) {
                  final cheesecake = cheesecakes[index];
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              cheesecake["name"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              cheesecake["image"],
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "₹${cheesecake["price"]}",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 4),
                          ],
                        ),
                        SizedBox(width: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () => addToCart(cheesecake),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(255, 180, 204, 1),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            ElevatedButton(
                              onPressed: () => addToCart(cheesecake),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Customize",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
