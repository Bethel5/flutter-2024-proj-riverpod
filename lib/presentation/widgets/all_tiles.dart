// import 'package:flutter/material.dart';
// import 'package:flutter_pet_pal/presentation/widgets/button.dart';

// class AllTile extends StatelessWidget {
//   final String name;
//   final String age;
//   final String gender;
//   final String species;
//   final String imagePath;

//   const AllTile({
//     Key? key,
//     required this.name,
//     required this.age,
//     required this.gender,
//     required this.species,
//     required this.imagePath,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.orange[200],
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     imagePath,
//                     width: double.infinity,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 2,
//                   left: 3,
//                   right: 3,
//                   child: MyButton(
//                     text: 'Adopt Me',
//                     onTap: () {
//                       Navigator.pushNamed(context, '/adoption_form');
//                     },
//                     height: 40,
//                     width: double.infinity,
//                     myColor: Color.fromRGBO(255, 184, 77, 0.525),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     name,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.favorite,
//                     color: Colors.grey[800],
//                     size: 28,
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/fav_page'); //opens fav page
//                   },
//                 ),
//               ],
//             ),
//             Text(
//               age,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             Text(
//               gender,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             Text(
//               species,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/widgets/button.dart';

class AllTile extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String species;
  final String imagePath;

  const AllTile({
    Key? key,
    required this.name,
    required this.age,
    required this.gender,
    required this.species,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orange[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 1, // Maintains the aspect ratio of the image
                    child: Image.network(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: const Text(
                            'Failed to load image',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: MyButton(
                    text: 'Adopt Me',
                    onTap: () {
                      Navigator.pushNamed(context, '/adoption_form');
                    },
                    height: 40,
                    width: double.infinity,
                    myColor: const Color.fromRGBO(255, 184, 77, 0.525),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.grey[800],
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/fav_page'); //opens fav page
                  },
                ),
              ],
            ),
            Text(
              age,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              gender,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              species,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


