import 'package:flutter/material.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';

class VenueAvailabilityScreen extends StatelessWidget {
  const VenueAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venue Availability',),
      ),
      body: Center(child: CustomText(text: "Venue Availability")),
    );
  }
}
