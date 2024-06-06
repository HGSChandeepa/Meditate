import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meditation/models/sleep_content_model.dart';

class SleepExerciseService {
  //create the box
  var sleepExerciseBox = Hive.box('sleep_contents');

  //Method to add a new sleep exercise
  Future<void> addSleepExercise(
      SleepContent sleepContent, BuildContext context) async {
    try {
      // Get all the sleep exercises, if any
      final allSleepExercises = sleepExerciseBox.get("sleep_contents");

      // Check if allSleepExercises is null or is not a list of maps
      List<SleepContent> sleepContentList = [];
      if (allSleepExercises != null && allSleepExercises is List) {
        sleepContentList = allSleepExercises.map((item) {
          if (item is Map<String, dynamic>) {
            return SleepContent.fromJson(item);
          } else {
            return SleepContent.fromJson(Map<String, dynamic>.from(item));
          }
        }).toList();
      }

      // Add the new sleep exercise
      sleepContentList.add(sleepContent);

      // Convert the sleepContentList back to a List<Map<String, dynamic>> before saving
      final List<Map<String, dynamic>> sleepContentListJson = sleepContentList
          .map((sleepContent) => sleepContent.toJson())
          .toList();

      // Save the new list of sleep exercises
      await sleepExerciseBox.put("sleep_contents", sleepContentListJson);

      // Show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sleep exercise added"),
          duration: Duration(seconds: 2),
        ),
      );

      print("Sleep exercise added");
    } catch (e) {
      print("Service error: $e");
    }
  }

  //Method to get all the sleep exercises
  List<SleepContent> getSleepExercises() {
    try {
      //get all the sleep exercises
      final dynamic allSleepExercises = sleepExerciseBox.get("sleep_contents");
      //convert the dynamic list to a list of SleepContent
      final List<SleepContent> sleepContentList = allSleepExercises
          .map((sleepContent) => SleepContent.fromJson(sleepContent))
          .toList();
      print(sleepContentList);
      return sleepContentList;
    } catch (e) {
      print("Service error: $e");
      return [];
    }
  }

  //Method to delete a sleep exercise
  Future<void> deleteSleepExercise(SleepContent sleepContent) async {
    try {
      // Get all the sleep exercises, if any
      final allSleepExercises = sleepExerciseBox.get("sleep_contents");

      // Check if allSleepExercises is null or is not a list of maps
      List<SleepContent> sleepContentList = [];
      if (allSleepExercises != null && allSleepExercises is List) {
        sleepContentList = allSleepExercises.map((item) {
          if (item is Map<String, dynamic>) {
            return SleepContent.fromJson(item);
          } else {
            return SleepContent.fromJson(Map<String, dynamic>.from(item));
          }
        }).toList();
      }

      // Remove the sleep exercise
      sleepContentList.remove(sleepContent);

      // Save the new list of sleep exercises
      await sleepExerciseBox.put("sleep_contents", sleepContentList);

      print("Sleep exercise deleted");
    } catch (e) {
      print("Service error: $e");
    }
  }
}
