import 'package:flutter/material.dart';
import 'package:meditation/widgets/meditatio_form.dart';
import 'package:meditation/widgets/mindufull_exercise_from.dart';
import 'package:meditation/widgets/sleep_content_form.dart';

class CreateMeditationPage extends StatefulWidget {
  const CreateMeditationPage({super.key});

  @override
  State<CreateMeditationPage> createState() => _CreateMeditationPageState();
}

class _CreateMeditationPageState extends State<CreateMeditationPage> {
  //slect the type of content
  String typeOfContent = 'Meditation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Page'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              //seelctor for the user to select the type of meditation or sleep content or mindfulness content
              children: [
                Row(
                  children: [
                    const Text('Type of Content'),

                    const SizedBox(
                      width: 20,
                    ),

                    //dropdown button
                    DropdownButton(
                      value: typeOfContent,
                      items: ['Meditation', 'Sleep', 'Mindfulness']
                          .map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          typeOfContent = value!;
                        });
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                //render the form based on the type of content selected
                if (typeOfContent == 'Meditation')
                  MeditationForm()
                else if (typeOfContent == 'Sleep')
                  SleepContentForm()
                else if (typeOfContent == 'Mindfulness')
                  MindFullExerciseForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
