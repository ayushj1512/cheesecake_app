import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:funkypanda/cheesecake_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) setIndex;

  const HomeScreen(
      {super.key,
      required void Function(int index) setIndexCallback,
      required this.setIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showButton = false;

  List<Map<String, String>> cheesecakes = [
    {
      "name": "Milk Chocolate Chip Cookie",
      "image": "assets/inspiration2.png",
      "price": "₹299",
      "description":
          "A rich and creamy milk chocolate chip cheesecake,\nlayered with smooth, velvety chocolate filling.",
      "reviews": "⭐⭐⭐⭐☆ (120 reviews)"
    },
    {
      "name": "Strawberry Cheesecake",
      "image": "assets/inspiration1.png",
      "price": "₹349",
      "description":
          "A creamy strawberry cheesecake with fresh strawberry toppings.",
      "reviews": "⭐⭐⭐⭐⭐ (150 reviews)"
    },
    {
      "name": "Biscoff Cheesecake",
      "image": "assets/inspiration3.png",
      "price": "₹399",
      "description":
          "A rich Biscoff-flavored cheesecake with a caramelized biscuit crust.",
      "reviews": "⭐⭐⭐⭐☆ (110 reviews)"
    },
    {
      "name": "Veg. Ramen",
      "image": "assets/inspiration4.png",
      "price": "₹299",
      "description":
          "A delicious milk chocolate chip cheesecake with a crunchy cookie base.",
      "reviews": "⭐⭐⭐⭐☆ (120 reviews)"
    },
  ];

  @override
  void initState() {
    super.initState();
    ;
    _scrollController.addListener(() {
      setState(() {
        _showButton = _scrollController.offset > 100;
      });
    });
  }

  void _navigateToDetails(
      BuildContext context, Map<String, String> cheesecake) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500), // Animation duration
        pageBuilder: (context, animation, secondaryAnimation) =>
            CheesecakeDetailsScreen(cheesecake: cheesecake),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 180, 204, 1),
        title: Text(
          "funky panda",
          style: GoogleFonts.anton(fontWeight: FontWeight.bold, fontSize: 36),
        ),
        centerTitle: true,
      ),
      floatingActionButton: _showButton
          ? Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.black,
                onPressed: () {},
                label: Row(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      "Order Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCarousel(),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(255, 180, 204, 1),
                  ),
                  child: Text(
                    "  Inspiration for your order  ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Cheesecake items in a list
            Column(
              children: cheesecakes.map((cheesecake) {
                bool isLeftAligned = cheesecakes.indexOf(cheesecake) % 2 == 0;

                return GestureDetector(
                  onTap: () => _navigateToDetails(context, cheesecake),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: isLeftAligned
                          ? [
                              _buildImage(cheesecake["image"]!),
                              SizedBox(width: 15),
                              _buildTextSection(cheesecake),
                            ]
                          : [
                              _buildTextSection(cheesecake),
                              SizedBox(width: 15),
                              _buildImage(cheesecake["image"]!),
                            ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Expanded(
      flex: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        child: Image.asset(
          imagePath,
          height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextSection(Map<String, String> cheesecake) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                cheesecake["name"]!,
                style: GoogleFonts.anton(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Learn More",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> carouselImages = [
  "assets/carousel1.jpg",
  "assets/carousel5.jpg",
  "assets/carousel6.jpg",
];
Widget buildCarousel() {
  return CarouselSlider(
    options: CarouselOptions(
      height: 300.0, // Adjust height as needed
      autoPlay: true, // Auto-slide feature
      autoPlayInterval: Duration(seconds: 3),
      enlargeCenterPage: false, // Disable center enlargement
      aspectRatio: 16 / 9,
      viewportFraction: 1.0, // Ensures full width
    ),
    items: carouselImages.map((imagePath) {
      return ClipRRect(
        borderRadius: BorderRadius.zero, // Remove rounded corners if needed
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover, // Ensure image covers the full space
          width: double.infinity,
        ),
      );
    }).toList(),
  );
}
