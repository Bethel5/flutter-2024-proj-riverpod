// import 'package:flutter/material.dart';
// import 'FormScreen.dart';
// import 'package:flutter_pet_pal/presentation/widgets/admin_tabs/admin_bunny_tab.dart';
// import 'package:flutter_pet_pal/presentation/widgets/admin_tabs/admin_cats_tab.dart';
// import 'package:flutter_pet_pal/presentation/widgets/admin_tabs/admin_dogs_tab.dart';
// import 'package:flutter_pet_pal/presentation/widgets/admin_tab.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: AdminPage(),
//   ));
// }

// class AdminPage extends StatefulWidget {
//   const AdminPage({Key? key}) : super(key: key);

//   @override
//   State<AdminPage> createState() => _AdminPageState();
// }

// class _AdminPageState extends State<AdminPage> {
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
//           leading: Builder(builder: (BuildContext context) {
//             return IconButton(
//               icon: Icon(Icons.menu),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             );
//           }),
//           backgroundColor: Colors.orange[300],
//           elevation: 0,
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.orange[200],
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(),
//                     Text(
//                       '   Admin',
//                       style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               ListTile(
//                 title: Text('Pet Listings'),
//                 onTap: () {},
//               ),
//               ListTile(
//                 title: Text('Adoption Applications'),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   ResponsiveCard(
//                     imagePath: 'lib/images/totals.jpg',
//                     label: 'Total pets: 40',
//                   ),
//                   SizedBox(width: 5.0),
//                   ResponsiveCard(
//                     imagePath: 'lib/images/Forms.jpg',
//                     label: 'Pending Approvals: 3',
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 14),
//             TabBar(tabs: myTabs),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   DogsTab(),
//                   CatsTab(),
//                   BunnyTab(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.blue[400],
//           hoverColor: Colors.blue[600],
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => FormScreen()),
//             );
//           },
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }

// class ResponsiveCard extends StatelessWidget {
//   final String imagePath;
//   final String label;

//   const ResponsiveCard({
//     Key? key,
//     required this.imagePath,
//     required this.label,
//   }) : super(key: key);



//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double cardWidth = constraints.maxWidth < 400 ? constraints.maxWidth * 0.8 : 350;
//         return Container(
//           width: cardWidth,
//           height: 230,
//           child: Card(
//             elevation: 4.0,
//             child: Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(50),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     image: DecorationImage(
//                       image: AssetImage(imagePath),
//                       fit: BoxFit.cover,
//                       alignment: Alignment.topCenter,
//                     ),
//                   ),
//                   alignment: Alignment.bottomCenter,
//                 ),
//                 Container(
//                   width: cardWidth,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     color: Color.fromARGB(255, 184, 207, 226),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       label,
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/widgets/admin_tabs/admin_bunny_tab.dart';
import 'package:flutter_pet_pal/presentation/widgets/admin_tabs/admin_cats_tab.dart';
import 'package:flutter_pet_pal/presentation/widgets/admin_tabs/admin_dogs_tab.dart';
import 'package:flutter_pet_pal/presentation/widgets/admin_tab.dart';
import 'Formscreen.dart';

void main() {
  runApp(const MaterialApp(
    home: AdminPage(),
  ));
}

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Widget> myTabs = const [
    MyTab(iconPath: 'lib/icons/dog.png'),
    MyTab(iconPath: 'lib/icons/smile.png'),
    MyTab(iconPath: 'lib/icons/easter-bunny.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          backgroundColor: Colors.orange[300],
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange[200],
                ),
                child: Row(
                  children: [
                    CircleAvatar(),
                    Text(
                      '   Admin',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Pet Listings'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Adoption Applications'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ResponsiveCard(
                    imagePath: 'lib/images/totals.jpg',
                    label: 'Total pets: 40',
                  ),
                  SizedBox(width: 5.0),
                  ResponsiveCard(
                    imagePath: 'lib/images/Forms.jpg',
                    label: 'Pending Approvals: 3',
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            TabBar(tabs: myTabs),
            Expanded(
              child: TabBarView(
                children: [
                  AdminDogsTab(),
                  AdminCatsTab(),
                  AdminBunnyTab(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[400],
          hoverColor: Colors.blue[600],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormScreen()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class ResponsiveCard extends StatelessWidget {
  final String imagePath;
  final String label;

  const ResponsiveCard({
    Key? key,
    required this.imagePath,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth < 400 ? constraints.maxWidth * 0.8 : 350;
        return Container(
          width: cardWidth,
          height: 230,
          child: Card(
            elevation: 4.0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                ),
                Container(
                  width: cardWidth,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color.fromARGB(255, 184, 207, 226),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
