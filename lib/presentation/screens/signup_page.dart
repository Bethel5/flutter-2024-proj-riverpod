import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/domain/auth/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/auth/providers.dart';
import '../widgets/button.dart';
import '../widgets/my_textfield.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    void signUp() {
      final fullName = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      ref.read(authNotifierProvider.notifier).signUp(fullName, email, password);
    }

    ref.listen<AsyncValue<User?>>(authNotifierProvider, (previous, next) {
      next.when(
        data: (_) {
          Navigator.pushNamed(context, '/user_page');
        },
        loading: () {},
        error: (err, stack) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 10),
                //image
                Padding(
                  padding:
                      const EdgeInsets.only(right: 100, left: 100, bottom: 5),
                  child: Image.asset(
                    'lib/images/signup.png',
                    scale: 5,
                  ),
                ),

                const SizedBox(height: 20),
                //text
                const Text(
                  "P E T P A L    A D O P T I O N",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 25),
                //textfield full name
                MyTextfield(
                    controller: nameController,
                    hintText: "Enter your full name",
                    obsecureText: false),

                const SizedBox(height: 25),
                //textfield email
                MyTextfield(
                    controller: emailController,
                    hintText: "Enter your email",
                    obsecureText: false),

                const SizedBox(height: 25),
                //textfield password
                MyTextfield(
                    controller: passwordController,
                    hintText: "Enter your password",
                    obsecureText: true),

                const SizedBox(height: 25),
                //textfield to confirm password
                MyTextfield(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obsecureText: true),

                const SizedBox(height: 30),
                //signup button
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: MyButton(
                    text: "Sign Up",
                    onTap: signUp,
                  ),
                ),

                const SizedBox(height: 7),
                //final message
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Congratulations on taking the first step towards finding your new furry friend!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
