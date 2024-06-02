import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation/models/functions_model.dart';
import 'package:meditation/models/mindfull_exercise_model.dart';
import 'package:meditation/models/sleep_content_model.dart';
import 'package:meditation/providers/filter_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Method to open the bottom sheet
  void openBottomSheet(BuildContext context, final title, final duration,
      final description, final category, final videoUrl) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  category,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 20),
                Text(
                  videoUrl.isNotEmpty ? videoUrl : 'No video available',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  '$duration min',
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).push(
                          '/functions',
                          // Passing the data to the next page
                          extra: FunctionsData(
                            category,
                            title: title,
                            duration: duration,
                            description: description,
                            url: videoUrl,
                          ),
                        );
                      },
                      child: const Text("Start"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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

                // Rearrange the data to show in the UI
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
                              return GestureDetector(
                                onTap: () {
                                  openBottomSheet(
                                    context,
                                    data.name,
                                    data.duration,
                                    data.description,
                                    data.category,
                                    data.videoUrl ?? '',
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: data is MindfulnessExercise
                                        ? Colors.blue.shade100.withOpacity(0.3)
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
                                        Text(data.category,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20)),
                                        Text(
                                          '${data.duration} min',
                                          style: const TextStyle(
                                            color: Colors.black38,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(data.name),
                                        Text(
                                          data.description,
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
