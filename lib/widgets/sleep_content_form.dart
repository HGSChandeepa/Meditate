import 'package:flutter/material.dart';
import 'package:meditation/models/sleep_content_model.dart';
import 'package:meditation/providers/meditation_provider.dart';
import 'package:meditation/providers/sleep_content_provider.dart';
import 'package:provider/provider.dart';

class SleepContentForm extends StatelessWidget {
  SleepContentForm({super.key});

  final _formKey = GlobalKey<FormState>();
  String _category = '';
  String _name = '';
  String _description = '';
  int _duration = 0;
  String _audioUrl = '';

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

              //submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    //create a new sleep content object
                    final sleepContent = SleepContent(
                      category: _category,
                      name: _name,
                      description: _description,
                      duration: _duration,
                      audioUrl: _audioUrl,
                    );

                    //use the provider to add the new sleep content
                    Provider.of<SleepContentProvider>(context, listen: false)
                        .addSleepContent(sleepContent, context);
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
