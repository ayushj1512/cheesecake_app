import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:funkypanda/checkoutpage.dart';

class CheckoutPage extends StatefulWidget {
  final double totalAmount;
  final int totalItems;
  final Map<String, int> items;

  const CheckoutPage({
    super.key,
    required this.totalAmount,
    required this.totalItems,
    required this.items,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String deliveryOption = "Pickup";

  double calculateFinalAmount() {
    double tax = widget.totalAmount * 0.05;
    return widget.totalAmount + tax;
  }

  void placeOrder() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "🎉 Order Confirmed!",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                "Thank you for your order! Your delicious cheesecakes will be ready soon. 😊",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 180, 204, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                ),
                child: Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 180, 204, 1),
        title: Text(
          "Checkout",
          style: GoogleFonts.anton(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Choose Delivery Option",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Divider(),
                    ListTile(
                      title: Text("Pickup"),
                      leading: Radio(
                        value: "Pickup",
                        groupValue: deliveryOption,
                        onChanged: (value) {
                          setState(() {
                            deliveryOption = value.toString();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text("Delivery"),
                      leading: Radio(
                        value: "Delivery",
                        groupValue: deliveryOption,
                        onChanged: (value) {
                          setState(() {
                            deliveryOption = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Payment Summary",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal:", style: TextStyle(fontSize: 16)),
                        Text("₹${widget.totalAmount.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax (5%):", style: TextStyle(fontSize: 16)),
                        Text(
                            "₹${(widget.totalAmount * 0.05).toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Grand Total:",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text("₹${calculateFinalAmount().toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text("Place Order",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
