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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                // Search bar
                TextField(
                  onChanged: (value) {
                    Provider.of<MindfullExerciseProvider>(context,
                            listen: false)
                        .searchMindfullExercise(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // List of mindfulness activities
                Consumer<MindfullExerciseProvider>(
                  builder: (context, mindfulnessExerciseProvider, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          mindfulnessExerciseProvider.mindfullExercise.length,
                      itemBuilder: (context, index) {
                        MindfulnessExercise mindfullExercise =
                            mindfulnessExerciseProvider.mindfullExercise[index];
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
