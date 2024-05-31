import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pet_pal/application/adoption_applications/adoption_applications_notifier.dart';
import 'package:flutter_pet_pal/domain/adoption_applications/adoption_applications.dart';
import 'package:flutter_pet_pal/presentation/screens/adoption_status_page.dart';

class AdoptionFormScreen extends ConsumerStatefulWidget {
  @override
  _AdoptionFormScreenState createState() => _AdoptionFormScreenState();
}

class _AdoptionFormScreenState extends ConsumerState<AdoptionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _experienceController = TextEditingController();
  String? _typeOfPet;
  String? _gender;
  String? _ageRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        elevation: 0,
        title: Text(
          'Adopt a Pet',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: constraints.maxWidth > 600 ? 600 : constraints.maxWidth * 0.9,
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      buildTextFormField(controller: _nameController, label: 'Full Name'),
                      SizedBox(height: 16.0),
                      buildTextFormField(controller: _addressController, label: 'Address'),
                      SizedBox(height: 16.0),
                      buildTextFormField(controller: _phoneNumberController, label: 'Phone Number', inputType: TextInputType.phone),
                      SizedBox(height: 16.0),
                      buildDropdownField(label: 'Type of Pet', items: ['Dog', 'Cat', 'Rabbit', 'Other'], onChanged: (value) => _typeOfPet = value),
                      SizedBox(height: 16.0),
                      buildDropdownField(label: 'Gender', items: ['Male', 'Female', 'Any'], onChanged: (value) => _gender = value),
                      SizedBox(height: 16.0),
                      buildDropdownField(label: 'Age Range', items: ['Baby', 'Young', 'Adult', 'Senior'], onChanged: (value) => _ageRange = value),
                      SizedBox(height: 32.0),
                      buildTextFormField(controller: _experienceController, label: 'Previous Pet Ownership Experience', maxLines: 5),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[400],
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final newApplication = AdoptionApplication(
                              id: '', // ID will be assigned by the backend
                              userId: '', // UserID will be assigned by the backend
                              fullName: _nameController.text,
                              address: _addressController.text,
                              phoneNumber: _phoneNumberController.text,
                              typeOfPet: _typeOfPet ?? '',
                              gender: _gender ?? '',
                              ageRange: _ageRange ?? '',
                              previousPetOwnershipExperience: _experienceController.text,
                              status: 'Pending', // Initial status
                            );

                            try {
                              final payload = newApplication.toJson(excludeIds: true); // Exclude IDs
                              await ref.read(adoptionNotifierProvider.notifier).createApplication(payload);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ApplicationStatusScreen()),
                              );
                            } catch (e) {
                              print('Error creating application: $e');
                            }
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextFormField({required TextEditingController controller, required String label, int maxLines = 1, TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: inputType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget buildDropdownField({required String label, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }
}
