// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Pet Adoption App',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//       ),
//       home: ApplicationStatusScreen(),
//     );
//   }
// }

// class ApplicationStatusScreen extends StatefulWidget {
//   @override
//   _ApplicationStatusScreenState createState() => _ApplicationStatusScreenState();
// }

// class _ApplicationStatusScreenState extends State<ApplicationStatusScreen> {
//   List<Map<String, dynamic>> applicationStatuses = [
//     {
//       'petName': 'Charlie',
//       'status': 'Pending',
//       'icon': Icons.hourglass_top,
//       'color': Colors.orange,
//       'petImageAsset': 'lib/images/dog1.jpeg',
//     },
//     {
//       'petName': 'Max',
//       'status': 'Approved',
//       'icon': Icons.check_circle_outline,
//       'color': Colors.green,
//       'petImageAsset': 'lib/images/bunny1.jpeg',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange[300],
//         elevation: 0,
//         title: Text(
//           'Application Status',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double cardWidth = constraints.maxWidth > 600 ? 600 : constraints.maxWidth * 0.9;
//           return ListView.builder(
//             itemCount: applicationStatuses.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Center(
//                 child: Container(
//                   width: cardWidth,
//                   child: ApplicationStatusCard(
//                     petName: applicationStatuses[index]['petName'],
//                     status: applicationStatuses[index]['status'],
//                     icon: applicationStatuses[index]['icon'],
//                     color: applicationStatuses[index]['color'],
//                     onEdit: () {},
//                     onDelete: () {
//                       setState(() {
//                         applicationStatuses.removeAt(index);
//                       });
//                     },
//                     petImageAsset: applicationStatuses[index]['petImageAsset'],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class ApplicationStatusCard extends StatelessWidget {
//   final String petName;
//   final String status;
//   final IconData icon;
//   final Color color;
//   final String petImageAsset;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;

//   const ApplicationStatusCard({
//     Key? key,
//     required this.petName,
//     required this.status,
//     required this.icon,
//     required this.color,
//     required this.petImageAsset,
//     required this.onEdit,
//     required this.onDelete,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundImage: AssetImage(petImageAsset),
//           backgroundColor: Colors.transparent,
//         ),
//         title: Text(
//           petName,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, color: color, size: 20.0),
//             SizedBox(width: 4.0),
//             Text(status),
//           ],
//         ),
//         trailing: Wrap(
//           spacing: 12,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.edit, color: Colors.orange),
//               onPressed: onEdit,
//             ),
//             IconButton(
//               icon: Icon(Icons.delete, color: Colors.brown),
//               onPressed: onDelete,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pet_pal/application/adoption_applications/adoption_applications_notifier.dart';
import 'package:flutter_pet_pal/domain/adoption_applications/adoption_applications.dart';

class ApplicationStatusScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adoptionState = ref.watch(adoptionNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        elevation: 0,
        title: Text(
          'Application Status',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: adoptionState.when(
        data: (applications) => LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth = constraints.maxWidth > 600 ? 600 : constraints.maxWidth * 0.9;
            return ListView.builder(
              itemCount: applications.length,
              itemBuilder: (BuildContext context, int index) {
                final application = applications[index];
                return Center(
                  child: Container(
                    width: cardWidth,
                    child: ApplicationStatusCard(
                      application: application,
                      onEdit: () {},
                      onDelete: () async {
                        await ref.read(adoptionNotifierProvider.notifier).deleteApplication(application.id);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class ApplicationStatusCard extends StatelessWidget {
  final AdoptionApplication application;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ApplicationStatusCard({
    Key? key,
    required this.application,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('lib/images/pet_placeholder.png'),
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          application.petType,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_top, color: Colors.orange, size: 20.0),
            SizedBox(width: 4.0),
            Text(application.status),
          ],
        ),
        trailing: Wrap(
          spacing: 12,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.orange),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.brown),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
