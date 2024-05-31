class Pet {
  final String id;
  final String name;
  final int age;
  final String species;
  final String gender;
  final String description;
  final String image;
  final String category;

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.species,
    required this.gender,
    required this.description,
    required this.image,
    required this.category,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      species: json['species'] ?? '',
      gender: json['gender'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Pet copyWith({
    String? id,
    String? name,
    int? age,
    String? species,
    String? gender,
    String? description,
    String? image,
    String? category,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      description: description ?? this.description,
      image: image ?? this.image,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'age': age,
      'species': species,
      'gender': gender,
      'description': description,
      'image': image,
      'category': category,
    };
  }
}
