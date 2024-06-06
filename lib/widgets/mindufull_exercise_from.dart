import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MindFullExerciseForm extends StatefulWidget {
  MindFullExerciseForm({super.key});

  @override
  State<MindFullExerciseForm> createState() => _MindFullExerciseFormState();
}

class _MindFullExerciseFormState extends State<MindFullExerciseForm> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //data
  String category = "";
  String name = "";
  String description = "";
  List<String> instructions = [];
  int duration = 0;
  String instructionsUrl = "";
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //form
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              //image picker
              if (_image != null)
                Image.file(
                  _image!,
                  height: 200,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: const Text('Pick from Camera'),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: const Text('Pick from Gallery'),
                  ),
                ],
              ),

              //category
              TextFormField(
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onSaved: (value) {
                  category = value!;
                },
              ),

              //name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),

              //description
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),

              //instructions
              TextFormField(
                decoration: const InputDecoration(labelText: 'Instructions'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter instructions';
                  }
                  return null;
                },
                onSaved: (value) {
                  instructions = value!.split('\n');
                },
              ),

              //duration
              TextFormField(
                decoration: const InputDecoration(labelText: 'Duration'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  duration = int.parse(value!);
                },
              ),

              //instructions url
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Instructions Url'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a instructions url';
                  }
                  return null;
                },
                onSaved: (value) {
                  instructionsUrl = value!;
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              //send the data to the API
            }
          },
          child: const Text('Submit'),
        )
      ],
    );
  }
}
