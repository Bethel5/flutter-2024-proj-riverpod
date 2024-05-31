import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/screens/user_page.dart';
import 'package:flutter_pet_pal/presentation/screens/signup_page.dart';
import 'package:flutter_pet_pal/presentation/screens/admin.dart';
import 'package:flutter_pet_pal/presentation/screens/intro_page.dart';
import 'package:flutter_pet_pal/presentation/screens/login_page.dart';
import 'package:flutter_pet_pal/presentation/screens/fav_page.dart';
import 'package:flutter_pet_pal/presentation/screens/adoption_form.dart';
import 'package:flutter_pet_pal/presentation/screens/adoption_status_page.dart';
import 'package:flutter_pet_pal/presentation/screens/appointment_manage.dart';
import 'package:flutter_pet_pal/presentation/screens/appointment_status.dart';
import 'package:flutter_pet_pal/presentation/screens/appointment.dart';
import 'package:flutter_pet_pal/presentation/screens/FormScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
        // theme: ThemeData(primarySwatch: Colors.orange),
        routes: {
          '/intro_page': (context) => IntroPage(),
          '/signup_page': (context) => SignupPage(),
          '/user_page': (context) => UserPage(),
          '/login_page': (context) => LoginPage(),
          '/fav_page': (context) => FavoritesPage(),
          '/admin': (context) => AdminPage(),
          '/adoption_form': (context) => AdoptionFormScreen(),
          '/status': (context) => ApplicationStatusScreen(),
          '/appointment': (context) => PetVisitScreen(),
          '/appointment_manage': (context) => AdminApp(),
          '/appoint_status': (context) => UserAppointmentsScreen(),
          '/FormScreen':(context) => FormScreen()
        });
  }
}
