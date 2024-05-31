import 'package:flutter/material.dart';

class Pet {
  final String name;
  final String imageUrl;
  final String species;

  Pet({
    required this.name,
    required this.imageUrl,
    required this.species,
  });
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Favorite Pets',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.orange[300],
      ),
      body: FavoritesPets(),
      backgroundColor: Colors.grey[200],
    );
  }
}

class FavoritesPets extends StatelessWidget {
  final List<Pet> favoritePets = [
    Pet(
      name: 'Fluffy',
      imageUrl: 'lib/images/cat1.jpeg',
      species: 'Siamese Cat',
    ),
    Pet(
      name: 'Whiskers',
      imageUrl: 'lib/images/dog1.jpeg',
      species: 'Cavalier King Charles Spaniel',
    ),
    Pet(
      name: 'Bunny',
      imageUrl: 'lib/images/bunny1.jpeg',
      species: 'Holland Lop Rabbit',
    ),
    Pet(
      name: 'Max',
      imageUrl: 'lib/images/dog2.jpeg',
      species: 'German Shepherd',
    ),
    Pet(
      name: 'Luna',
      imageUrl: 'lib/images/cat3.jpeg',
      species: 'Maine Coon',
    ),
    Pet(
      name: 'Rocky',
      imageUrl: 'lib/images/cat4.jpeg',
      species: 'Ragdoll',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          children: favoritePets.map((pet) => _buildPetCard(context, pet)).toList(),
        ),
      ),
    );
  }

  Widget _buildPetCard(BuildContext context, Pet pet) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        child: Card(
          color: Colors.grey[100],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SizedBox(
            height: 120,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            bottomLeft: Radius.circular(16.0),
                          ),
                          child: Image.asset(
                            pet.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pet.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Breed: ${pet.species}',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 110, 54, 54),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
