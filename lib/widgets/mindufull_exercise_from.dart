import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditation/models/mindfull_exercise_model.dart';
import 'package:meditation/providers/custom_data_provider.dart';
import 'package:meditation/providers/mindfull_exercise_provider.dart';
import 'package:provider/provider.dart';

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
  File? imagepath;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        imagepath = File(pickedFile.path);
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
              if (imagepath != null)
                Image.file(
                  imagepath!,
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
                  instructions = value!.split(',');
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
              //convert the imagepath to a string
              final imagePathString = imagepath?.path ?? '';
              print(imagePathString);
              //create a new MindFullExercise object
              final MindfulnessExercise mindFullExercise = MindfulnessExercise(
                category: category,
                name: name,
                description: description,
                instructions: instructions,
                duration: duration,
                instructionsUrl: instructionsUrl,
                imagePath: imagePathString,
              );

              //use the provider to add the new mindfull content
              Provider.of<CustomDataProvider>(context, listen: false)
                  .addMindfulExercise(mindFullExercise, context);
            }
          },
          child: const Text('Submit'),
        )
      ],
    );
  }
}
