import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation/models/mindfull_exercise_model.dart';
import 'package:meditation/providers/mindfull_exercise_provider.dart';
import 'package:meditation/router/route_names.dart';
import 'package:provider/provider.dart';

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mindfull Page'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: [
                  //list of mindfullness activities here
                  Consumer<MindfullExerciseProvider>(
                    builder: (context, mindfulnessExercise, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mindfulnessExercise.mindfullExercise.length,
                        itemBuilder: (context, index) {
                          MindfulnessExercise mindfullExercise =
                              mindfulnessExercise.mindfullExercise[index];
                          return Card(
                            child: ListTile(
                              title: Text(mindfullExercise.name),
                              subtitle: Text(
                                mindfullExercise.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                  RouteNames.mindFullExercise,
                                  queryParameters: {
                                    'mindfullExercise':
                                        jsonEncode(mindfullExercise.toJson()),
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
