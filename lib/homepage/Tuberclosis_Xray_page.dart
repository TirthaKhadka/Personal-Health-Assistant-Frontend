import 'package:flutter/material.dart';

class TuberculosisPage extends StatelessWidget {
  const TuberculosisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // page background
      appBar: AppBar(
        backgroundColor: Colors.white, // pink app bar
        title: Row(
          children: [
            Image.asset(
              'assets/tb_logofinal.png', // your TB logo
              height: 30,
              width: 30,
              
               // makes logo white if it's an icon
            ),
            const SizedBox(width: 10),
            const Text(
              "Tuberculosis Detection",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.pink, // matches theme
          ),
        ),
      ),
    );
  }
}
