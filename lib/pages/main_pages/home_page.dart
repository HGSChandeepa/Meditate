import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meditation/models/mindfull_exercise_model.dart';
import 'package:meditation/models/sleep_content_model.dart';
import 'package:meditation/providers/filter_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<FilterdDataprovider>(context, listen: false)
              .getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading data'));
            }

            return Consumer<FilterdDataprovider>(
              builder: (context, filterData, child) {
                final completeData = filterData.filteredData;

                //re arrange the data to show in the UI
                completeData.shuffle();
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Home Page",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Select a category to start exploring",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FilterChip(
                                label: const Text("All"),
                                onSelected: (bool value) {
                                  filterData.filterData("All");
                                },
                              ),
                              FilterChip(
                                label: const Text("Mindfulness"),
                                onSelected: (bool value) {
                                  filterData.filterData("Mindfulness");
                                },
                              ),
                              FilterChip(
                                label: const Text("Meditation"),
                                onSelected: (bool value) {
                                  filterData.filterData("Meditation");
                                },
                              ),
                              FilterChip(
                                label: const Text("Sleep Stories"),
                                onSelected: (bool value) {
                                  filterData.filterData("Sleep Stories");
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (completeData.isNotEmpty)
                          StaggeredGrid.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: completeData.map((data) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        //if data is of type MindfulnessExercise return Colors.blue else if data is of type SleepContent return Colors.green else return Colors.red
                                        data is MindfulnessExercise
                                            ? Colors.blue.shade100
                                                .withOpacity(0.3)
                                            : data is SleepContent
                                                ? Colors.green.shade100
                                                    .withOpacity(0.3)
                                                : Colors.red.shade100
                                                    .withOpacity(0.3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data.category ?? 'Unknown',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20)),
                                        Text(
                                          data.duration.toString() + ' min' ??
                                              'Unknown',
                                          style: const TextStyle(
                                            color: Colors.black38,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(data.name ?? 'Unknown'),
                                        Text(
                                          data.description ?? 'No description',
                                          maxLines:
                                              (data.description.length / 2)
                                                  .toInt(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        else
                          const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
