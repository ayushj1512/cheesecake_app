import 'package:flutter/material.dart';
import 'package:funkypanda/cart.dart';
import 'package:funkypanda/checkoutpage.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart2 extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const Cart2({super.key, required this.cartItems});

  @override
  State<Cart2> createState() => _Cart2State();
}

class _Cart2State extends State<Cart2> {
  double calculateTotal() {
    double total = widget.cartItems.fold(0, (sum, item) => sum + item["price"]);
    double tax = total * 0.05; // 5% tax
    return total + tax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "your cart",
          style: GoogleFonts.anton(fontSize: 28),
        ),
        backgroundColor: Color.fromRGBO(255, 180, 204, 1),
      ),
      body: widget.cartItems.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return ListTile(
                        leading: Image.asset(item["image"], width: 50),
                        title: Text(item["name"]),
                        subtitle: Text("₹${item["price"]}"),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              widget.cartItems.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal:", style: TextStyle(fontSize: 16)),
                          Text("₹${calculateTotal() / 1.05}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tax (5%):", style: TextStyle(fontSize: 16)),
                          Text(
                              "₹${calculateTotal() - (calculateTotal() / 1.05)}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("₹${calculateTotal().toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckoutPage(
                                        totalAmount: calculateTotal(),
                                        totalItems: 0,
                                        items: {},
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 180, 204, 1),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 50),
                        ),
                        child: Text("Checkout",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
