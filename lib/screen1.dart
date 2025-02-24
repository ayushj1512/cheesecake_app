import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showButton = false;
  late VideoPlayerController _videoController;
  bool _videoError = false;

  List<Map<String, String>> cheesecakes = [
    {
      "name": "Milk Chocolate Chip Cookie",
      "image": "assets/inspiration2.png",
      "price": "₹299",
      "description":
          "A delicious milk chocolate chip cheesecake with a crunchy cookie base.",
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
      "image": "assets/inspiration4.png",
      "price": "₹399",
      "description":
          "A rich Biscoff-flavored cheesecake with a caramelized biscuit crust.",
      "reviews": "⭐⭐⭐⭐☆ (110 reviews)"
    },
    {
      "name": "Milk Chocolate Chip Cookie",
      "image": "assets/inspiration2.png",
      "price": "₹299",
      "description":
          "A delicious milk chocolate chip cheesecake with a crunchy cookie base.",
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
      "image": "assets/inspiration4.png",
      "price": "₹399",
      "description":
          "A rich Biscoff-flavored cheesecake with a caramelized biscuit crust.",
      "reviews": "⭐⭐⭐⭐☆ (110 reviews)"
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _scrollController.addListener(() {
      setState(() {
        _showButton = _scrollController.offset > 100;
      });
    });
  }

  Future<void> _initializeVideo() async {
    try {
      _videoController =
          VideoPlayerController.asset('assets/background-video3a.mp4');
      await _videoController.initialize();
      _videoController.setLooping(true);
      _videoController.play();
      setState(() {});
    } catch (e) {
      setState(() {
        _videoError = true;
      });
      debugPrint("Video loading error: $e");
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _navigateToDetails(
      BuildContext context, Map<String, String> cheesecake) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheesecakeDetailsScreen(cheesecake: cheesecake),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
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
            // Video Player with error handling
            _videoError
                ? Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Text(
                        "⚠️ Video failed to load",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),
                  )
                : _videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      )
                    : Container(
                        height: 200,
                        color: Colors.black,
                        child: Center(child: CircularProgressIndicator()),
                      ),
            SizedBox(height: 10),

            // Title text
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

class CheesecakeDetailsScreen extends StatelessWidget {
  final Map<String, String> cheesecake;
  const CheesecakeDetailsScreen({required this.cheesecake, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 180, 204, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 180, 204, 1),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.cancel),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  cheesecake["image"]!,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              cheesecake["name"]!,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              cheesecake["price"]!,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              cheesecake["description"]!,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
