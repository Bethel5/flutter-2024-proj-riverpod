// import 'package:flutter/material.dart';
// import 'package:flutter_pet_pal/presentation/screens/fav_page.dart';
// import 'package:flutter_pet_pal/presentation/widgets/drawer.dart';
// import 'package:flutter_pet_pal/presentation/widgets/my_tab.dart';
// import 'package:flutter_pet_pal/presentation/widgets/tab/bunny_tab.dart';
// import 'package:flutter_pet_pal/presentation/widgets/tab/cat_tab.dart';
// import 'package:flutter_pet_pal/presentation/widgets/tab/dog_tab.dart';

// class UserPage extends StatefulWidget {
//   const UserPage({super.key});

//   @override
//   State<UserPage> createState() => _UserPageState();
// }

// class _UserPageState extends State<UserPage> {
//   //my tabs
//   List<Widget> myTabs = const [
//     MyTab(iconPath: 'lib/icons/dog.png'),
//     MyTab(iconPath: 'lib/icons/smile.png'),
//     MyTab(iconPath: 'lib/icons/easter-bunny.png'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: myTabs.length,
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           backgroundColor: Colors.orange[300],
//           elevation: 0,
//           title: Center(
//             child: Text(
//               'P E T P A L',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 15.0),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.favorite,
//                   color: Colors.grey[800],
//                   size: 28,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => FavoritesPage()),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//         drawer: AppDrawer(),
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             // Determine padding and font size based on screen size
//             double padding = constraints.maxWidth * 0.05;
//             double fontSize = constraints.maxWidth * 0.06;

//             return Column(
//               children: [
//                 // Find your best friend!
//                 Padding(
//                   padding: EdgeInsets.all(padding),
//                   child: Text(
//                     "Find your new Bestfriend!!",
//                     style: TextStyle(
//                       fontSize: fontSize,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 14,
//                 ),
//                 // Tab bar
//                 TabBar(tabs: myTabs),
//                 // Tab bar view
//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       // Dogs page
//                       DogsTab(),
//                       // Cats page
//                       CatsTab(),
//                       // Bunny page
//                       BunnyTab(),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/application/pets/pet_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pet_pal/presentation/screens/fav_page.dart';
import 'package:flutter_pet_pal/presentation/widgets/drawer.dart';
import 'package:flutter_pet_pal/presentation/widgets/my_tab.dart';
import 'package:flutter_pet_pal/presentation/widgets/tab/bunny_tab.dart';
import 'package:flutter_pet_pal/presentation/widgets/tab/cat_tab.dart';
import 'package:flutter_pet_pal/presentation/widgets/tab/dog_tab.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsState = ref.watch(petNotifierProvider);

    ref.read(petNotifierProvider.notifier).fetchPets();

    List<Widget> myTabs = const [
      MyTab(iconPath: 'lib/icons/dog.png'),
      MyTab(iconPath: 'lib/icons/smile.png'),
      MyTab(iconPath: 'lib/icons/easter-bunny.png'),
    ];

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          elevation: 0,
          title: const Center(
            child: Text(
              'P E T P A L',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.grey[800],
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesPage()),
                  );
                },
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: petsState.when(
          data: (pets) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Find your new Bestfriend!!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TabBar(tabs: myTabs),
                Expanded(
                  child: TabBarView(
                    children: [
                      DogsTab(pets: pets.where((pet) => pet.category == 'Dog').toList()),
                      CatsTab(pets: pets.where((pet) => pet.category == 'Cat').toList()),
                      BunnyTab(pets: pets.where((pet) => pet.category == 'Bunny').toList()),
                    ],
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}

