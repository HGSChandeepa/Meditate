import 'package:flutter/material.dart';
import 'package:meditation/models/sleep_content_model.dart';
import 'package:meditation/providers/custom_data_provider.dart';
import 'package:provider/provider.dart';

class SleepExercisesTab extends StatelessWidget {
  const SleepExercisesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          //Add a list of meditations here
          Consumer<CustomDataProvider>(
            builder: (context, data, child) {
              final List<SleepContent> sleepData = data.getSleepExercises();
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sleepData.length,
                itemBuilder: (context, index) {
                  final SleepContent sleepContent = sleepData[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(sleepContent.name),
                      subtitle: Text(sleepContent.description),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          data.deleteSleepContent(sleepContent, context);
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
