import 'package:flutter/material.dart';
import 'package:toot/presentation/widgets/onboarding_preview.dart';

class OnboardingScreen extends StatelessWidget {
  final List<String> images = [
    'assets/images/sdfg.png',
    'assets/images/6.png',
  ];

  final List<String> titles = [
    'Quickly search and add healthy foods to your cart',
    'With one click you can add every ingredient for a recipe to your cart'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ImagesSlider(
            imagesPreview: images,
            title: titles,
          ),
        ],
      ),
    );
  }
}
