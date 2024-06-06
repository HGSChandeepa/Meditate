import 'package:flutter/material.dart';
import 'package:meditation/models/meditation_model.dart';
import 'package:meditation/providers/filter_provider.dart';
import 'package:meditation/providers/meditation_provider.dart';
import 'package:provider/provider.dart';

class MeditationForm extends StatelessWidget {
  MeditationForm({super.key});

  final _formKey = GlobalKey<FormState>();
  String _category = '';
  String _name = '';
  String _description = '';
  int _duration = 0;
  String _audioUrl = '';
  String _videoUrl = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      //form
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
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
                  _category = value!;
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
                  _name = value!;
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
                  _description = value!;
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
                  _duration = int.parse(value!);
                },
              ),

              //audio url
              TextFormField(
                decoration: const InputDecoration(labelText: 'Audio Url'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an audio url';
                  }
                  return null;
                },
                onSaved: (value) {
                  _audioUrl = value!;
                },
              ),

              //video url
              TextFormField(
                decoration: const InputDecoration(labelText: 'Video Url'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a video url';
                  }
                  return null;
                },
                onSaved: (value) {
                  _videoUrl = value!;
                },
              ),

              //submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    //create a new meditation
                    final meditation = MeditationContent(
                      category: _category,
                      name: _name,
                      description: _description,
                      duration: _duration,
                      audioUrl: _audioUrl,
                      videoUrl: _videoUrl,
                    );

                    //add the meditation
                    Provider.of<MeditationProvider>(context, listen: false)
                        .addMeditation(meditation, context);
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        )
      ],
    );
  }
}
