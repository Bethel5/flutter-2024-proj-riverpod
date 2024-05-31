import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pet_pal/domain/pets/pet.dart';
import 'package:flutter_pet_pal/application/pets/pet_notifier.dart';
import 'package:image_picker/image_picker.dart';

class FormScreen extends StatefulWidget {
  final Pet? pet;

  const FormScreen({Key? key, this.pet}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _speciesController = TextEditingController();
  final _genderController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _category;
  String? _imagePath;
  File? _imageFile;
  Uint8List? _webImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() async {
        if (kIsWeb) {
          _webImage = await image.readAsBytes();
          _imagePath = image.path;
        } else {
          _imageFile = File(image.path);
          _imagePath = image.path;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.pet != null) {
      _nameController.text = widget.pet!.name;
      _ageController.text = widget.pet!.age.toString();
      _speciesController.text = widget.pet!.species;
      _genderController.text = widget.pet!.gender;
      _descriptionController.text = widget.pet!.description;
      _category = widget.pet!.category;
      _imagePath = widget.pet!.image;
      if (!kIsWeb) {
        _imageFile = File(widget.pet!.image);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pet == null ? 'Add a new pet' : 'Edit pet'),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double containerWidth = constraints.maxWidth * 0.8;
            return Center(
              child: Container(
                margin: EdgeInsets.all(30.0),
                width: containerWidth > 400 ? 400 : containerWidth,
                color: Colors.orange[200],
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.pet == null ? 'Add a new pet' : 'Edit pet',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _ageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Age',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an age';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _speciesController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Species',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a species';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _genderController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Gender',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a gender';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Description',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        DropdownButtonFormField<String>(
                          value: _category,
                          onChanged: (value) {
                            setState(() {
                              _category = value;
                            });
                          },
                          items: ['Dog', 'Cat', 'Bunny']
                              .map((category) => DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(category),
                                  ))
                              .toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Category',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        IconButton(
                          icon: Icon(Icons.add_photo_alternate),
                          onPressed: _pickImage,
                        ),
                        if (_imagePath != null)
                          kIsWeb
                              ? Image.network(
                                  _imagePath!,
                                  height: 200,
                                )
                              : _imageFile != null
                                  ? Image.file(
                                      _imageFile!,
                                      height: 200,
                                    )
                                  : Container(),
                        SizedBox(height: 10.0),
                        Consumer(
                          builder: (context, ref, child) {
                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final newPet = Pet(
                                    id: widget.pet?.id ?? '',
                                    name: _nameController.text,
                                    age: int.parse(_ageController.text),
                                    species: _speciesController.text,
                                    gender: _genderController.text,
                                    description: _descriptionController.text,
                                    category: _category ?? 'Dog',
                                    image: _imagePath ?? '',
                                  );
                                  if (widget.pet == null) {
                                    if (kIsWeb) {
                                      ref.read(petNotifierProvider.notifier).addPet(newPet, webImage: _webImage);
                                    } else {
                                      ref.read(petNotifierProvider.notifier).addPet(newPet, imageFile: _imageFile);
                                    }
                                  } else {
                                    ref.read(petNotifierProvider.notifier).updatePet(widget.pet!.id, newPet);
                                  }
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Done'),
                            );
                          },
                        ),
                        if (widget.pet != null) ...[
                          SizedBox(height: 10.0),
                          Consumer(
                            builder: (context, ref, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  ref.read(petNotifierProvider.notifier).deletePet(widget.pet!.id);
                                  Navigator.pop(context);
                                },
                                child: Text('Delete'),
                              );
                            },
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}














