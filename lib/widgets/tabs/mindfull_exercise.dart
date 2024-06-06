import 'package:flutter/material.dart';
import 'package:meditation/models/mindfull_exercise_model.dart';
import 'package:meditation/models/sleep_content_model.dart';
import 'package:meditation/providers/custom_data_provider.dart';
import 'package:provider/provider.dart';

class MindfulExercisesTab extends StatelessWidget {
  const MindfulExercisesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          //Add a list of meditations here
          Consumer<CustomDataProvider>(
            builder: (context, data, child) {
              final List<MindfulnessExercise> mindFullData =
                  data.getMindfulExercises();
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: mindFullData.length,
                itemBuilder: (context, index) {
                  final MindfulnessExercise mindfulnessExercise =
                      mindFullData[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(mindfulnessExercise.name),
                      subtitle: Text(mindfulnessExercise.description),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          data.deleteMindfulExercise(mindfulnessExercise);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
