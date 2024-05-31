class AdoptionApplication {
  final String id;
  final String userId;
  final String fullName;
  final String address;
  final String phoneNumber;
  final String typeOfPet;
  final String gender;
  final String ageRange;
  final String previousPetOwnershipExperience;
  final String status;

  AdoptionApplication({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.typeOfPet,
    required this.gender,
    required this.ageRange,
    required this.previousPetOwnershipExperience,
    required this.status,
  });

  factory AdoptionApplication.fromJson(Map<String, dynamic> json) {
    return AdoptionApplication(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      typeOfPet: json['typeOfPet'] ?? '',
      gender: json['gender'] ?? '',
      ageRange: json['ageRange'] ?? '',
      previousPetOwnershipExperience: json['previousPetOwnershipExperience'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson({bool excludeIds = false}) {
    final data = {
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'typeOfPet': typeOfPet,
      'gender': gender,
      'ageRange': ageRange,
      'previousPetOwnershipExperience': previousPetOwnershipExperience,
      'status': status,
    };
    if (!excludeIds) {
      data['_id'] = id;
      data['userId'] = userId;
    }
    return data;
  }
}
