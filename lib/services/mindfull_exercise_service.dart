import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meditation/models/mindfull_exercise_model.dart';

class MindFullExerciseService {
  //initilize the hive box
  var mindFullExerciseBox = Hive.box('mindfull_exercises');

  //Method to add a new mindfull exercise
  Future<void> addMindFullExercise(
      MindfulnessExercise mindfullExercise, BuildContext context) async {
    try {
      // Get all the mindfull exercises, if any
      final allMindFullExercises =
          mindFullExerciseBox.get("mindfull_exercises");

      // Check if allMindFullExercises is null or is not a list of maps
      List<MindfulnessExercise> mindfullExerciseList = [];
      if (allMindFullExercises != null && allMindFullExercises is List) {
        mindfullExerciseList = allMindFullExercises.map((item) {
          if (item is Map<String, dynamic>) {
            return MindfulnessExercise.fromJson(item);
          } else {
            return MindfulnessExercise.fromJson(
                Map<String, dynamic>.from(item));
          }
        }).toList();
      }

      // Add the new mindfull exercise
      mindfullExerciseList.add(mindfullExercise);

      // Convert the mindfullExerciseList back to a List<Map<String, dynamic>> before saving
      final List<Map<String, dynamic>> mindfullExerciseListJson =
          mindfullExerciseList
              .map((mindfullExercise) => mindfullExercise.toJson())
              .toList();

      // Save the new list of mindfull exercises
      await mindFullExerciseBox.put(
          "mindfull_exercises", mindfullExerciseListJson);

      //show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mindfull exercise added"),
          duration: Duration(seconds: 2),
        ),
      );

      print("Mindfull exercise added");
    } catch (e) {
      print("Service error: $e");
    }
  }

  //Method to get all the mindfull exercises
  List<MindfulnessExercise> getMindFullExercises() {
    try {
      //get all the mindfull exercises
      final dynamic allMindFullExercises =
          mindFullExerciseBox.get("mindfull_exercises");
      //convert the dynamic list to a list of MindfulnessExercise
      final List<MindfulnessExercise> mindfullExerciseList =
          allMindFullExercises
              .map((mindfullExercise) =>
                  MindfulnessExercise.fromJson(mindfullExercise))
              .toList();
      print(mindfullExerciseList);
      return mindfullExerciseList;
    } catch (e) {
      print("Service error: $e");
      return [];
    }
  }

  //Method to delete a mindfull exercise
  Future<void> deleteMindFullExercise(
      MindfulnessExercise mindfullExercise) async {
    try {
      // Get all the mindfull exercises, if any
      final allMindFullExercises =
          mindFullExerciseBox.get("mindfull_exercises");

      // Check if allMindFullExercises is null or is not a list of maps
      List<MindfulnessExercise> mindfullExerciseList = [];
      if (allMindFullExercises != null && allMindFullExercises is List) {
        mindfullExerciseList = allMindFullExercises.map((item) {
          if (item is Map<String, dynamic>) {
            return MindfulnessExercise.fromJson(item);
          } else {
            return MindfulnessExercise.fromJson(
                Map<String, dynamic>.from(item));
          }
        }).toList();
      }

      // Remove the mindfull exercise
      mindfullExerciseList.remove(mindfullExercise);

      // Save the new list of mindfull exercises
      await mindFullExerciseBox.put("mindfull_exercises", mindfullExerciseList);

      print("Mindfull exercise deleted");
    } catch (e) {
      print("Service error: $e");
    }
  }
}
