import 'package:flutter/material.dart';
import 'package:meditation/models/meditation_model.dart';
import 'package:meditation/providers/custom_data_provider.dart';
import 'package:provider/provider.dart';

class MeditationsTab extends StatelessWidget {
  const MeditationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Add a list of meditations here
          Consumer<CustomDataProvider>(
            builder: (context, data, child) {
              final List<MeditationContent> meditations = data.getMeditations();
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: meditations.length,
                itemBuilder: (context, index) {
                  final MeditationContent meditation = meditations[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(meditation.name),
                      subtitle: Text(meditation.description),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          data.deleteMeditation(meditation, context);
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
