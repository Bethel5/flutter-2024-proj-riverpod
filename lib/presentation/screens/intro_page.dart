import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/widgets/button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Text(
                    "PET PAL",
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Image.asset(
                        "lib/images/pet-shop.png",
                        width: constraints.maxWidth * 0.7,
                        height: constraints.maxWidth * 0.7,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "FIND YOUR FURRY FRIEND!",
                    style: TextStyle(fontSize: 38, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Whether you're looking for a playful puppy, a cuddly kitten, or a loyal companion, we've got a wide selection of adorable pets waiting to meet you.",
                    style: TextStyle(color: Colors.black, fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: MyButton(
                      text: "Get Started",
                      onTap: () {
                        Navigator.pushNamed(context, '/login_page');
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
