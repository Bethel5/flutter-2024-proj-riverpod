import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/auth/providers.dart';
import '../../domain/auth/user.dart';
import '../widgets/button.dart';
import '../widgets/my_textfield.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void signIn() {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      ref.read(authNotifierProvider.notifier).signIn(email, password);
    }

    ref.listen<AsyncValue<User?>>(authNotifierProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            if (user.role == 'admin') {
              Navigator.pushNamed(context, '/admin');
            } else if (user.role == 'user') {
              Navigator.pushNamed(context, '/user_page');
            }
          }
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
                const SizedBox(height: 15),
                //image
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, right: 100, left: 100, bottom: 5),
                  child: Image.asset('lib/images/login.png'),
                ),

                //text
                const SizedBox(height: 15),

                const Text(
                  "Hey there! Welcome back",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                const SizedBox(
                  height: 15,
                ),

                //textfield email
                MyTextfield(
                  controller: emailController,
                  hintText: "Enter your Email",
                  obsecureText: false,
                ),

                const SizedBox(
                  height: 15,
                ),
                //textfield password
                MyTextfield(
                  controller: passwordController,
                  hintText: "Enter your password",
                  obsecureText: true,
                ),

                const SizedBox(
                  height: 15,
                ),
                //button(sign in)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: MyButton(
                    text: "Log in",
                    onTap: signIn,
                  ),
                ),

                const SizedBox(height: 10),
                //text(already have an account login)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    //sign up clickable
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup_page');
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
