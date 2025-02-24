import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'more',
          style: GoogleFonts.anton(fontSize: 28),
        ),
        backgroundColor:
            const Color.fromRGBO(255, 180, 204, 1), // Set app bar color
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: ListView(
        children: [
          _buildSectionHeader('General'),
          _buildListItem(Icons.store, 'Store Locations'),
          _buildListItem(Icons.fastfood, 'Nutrition & Allergy'),
          _buildListItem(Icons.book, 'Food Journal'),
          const Divider(),
          _buildSectionHeader('My Account'),
          _buildListItem(Icons.manage_accounts_rounded, 'Account Settings'),
          _buildListItem(Icons.card_giftcard, 'Check Gift Card Balance'),
          _buildListItem(Icons.money, 'Funky Cash'),
          _buildListItem(Icons.history, 'Order History'),
          _buildListItem(Icons.local_offer, 'Vouchers & Promotions'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
