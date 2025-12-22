import 'package:flutter/material.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';

class VenueDetailsScreen extends StatelessWidget {
  const VenueDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venue Details'),
      ),
      body: Center(child: CustomText(text: "Venue Details")),
    );
  }
}
