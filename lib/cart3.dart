import 'package:flutter/material.dart';
import 'package:funkypanda/checkoutpage.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart3 extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const Cart3({super.key, required this.cartItems});

  @override
  State<Cart3> createState() => _Cart3State();
}

class _Cart3State extends State<Cart3> {
  Map<String, int> itemQuantities = {};

  @override
  void initState() {
    super.initState();
    for (var item in widget.cartItems) {
      itemQuantities[item['name']] = (itemQuantities[item['name']] ?? 0) + 1;
    }
  }

  void updateQuantity(String name, int change) {
    setState(() {
      if (itemQuantities.containsKey(name)) {
        itemQuantities[name] = (itemQuantities[name]! + change).clamp(0, 99);
        if (itemQuantities[name] == 0) {
          itemQuantities.remove(name);
          widget.cartItems.removeWhere((item) => item['name'] == name);
        }
      }
    });
  }

  double calculateSubtotal() {
    double subtotal = 0;
    widget.cartItems.forEach((item) {
      subtotal += (item['price'] * (itemQuantities[item['name']] ?? 1));
    });
    return subtotal;
  }

  double calculateTax() {
    return calculateSubtotal() * 0.05;
  }

  double calculateTotal() {
    return calculateSubtotal() + calculateTax();
  }

  int totalItems() {
    return itemQuantities.values.fold(0, (sum, quantity) => sum + quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 180, 204, 1),
        elevation: 0,
        title: Text(
          "Your Cart",
          style: GoogleFonts.anton(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: itemQuantities.length,
                itemBuilder: (context, index) {
                  String name = itemQuantities.keys.elementAt(index);
                  Map<String, dynamic> cheesecake = widget.cartItems
                      .firstWhere((item) => item['name'] == name);
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(cheesecake['image'],
                            height: 60, width: 60, fit: BoxFit.cover),
                      ),
                      title: Text(
                        cheesecake['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                          "₹${cheesecake['price']} x ${itemQuantities[name]}",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700])),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline,
                                color: Colors.red),
                            onPressed: () => updateQuantity(name, -1),
                          ),
                          Text("${itemQuantities[name]}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline,
                                color: Colors.green),
                            onPressed: () => updateQuantity(name, 1),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(thickness: 1.5, color: Colors.grey[400]),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Items: ${totalItems()}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text("Subtotal: ₹${calculateSubtotal().toStringAsFixed(2)}",
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[800])),
                    Text("Tax (5%): ₹${calculateTax().toStringAsFixed(2)}",
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[800])),
                    Divider(thickness: 1, color: Colors.grey[400]),
                    Text(
                        "Total Amount: ₹${calculateTotal().toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                totalAmount: calculateTotal(),
                                totalItems: totalItems(),
                                items: Map.from(itemQuantities),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("Proceed to Checkout",
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
