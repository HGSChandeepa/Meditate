import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meditation/models/meditation_model.dart';

class MeditationService {
  //craete the Box for Hive
  final _meditationBox = Hive.box('meditations');

  //add a new meditation
  Future<void> addMeditation(
      MeditationContent meditation, BuildContext context) async {
    try {
      // Get all the meditations, if any
      final allMeditations = _meditationBox.get("meditations");

      // Check if allMeditations is null or is not a list of maps
      List<MeditationContent> meditationList = [];
      if (allMeditations != null && allMeditations is List) {
        meditationList = allMeditations.map((item) {
          if (item is Map<String, dynamic>) {
            return MeditationContent.fromJson(item);
          } else {
            return MeditationContent.fromJson(Map<String, dynamic>.from(item));
          }
        }).toList();
      }

      // Add the new meditation
      meditationList.add(meditation);

      // Convert the meditationList back to a List<Map<String, dynamic>> before saving
      final List<Map<String, dynamic>> meditationListJson =
          meditationList.map((meditation) => meditation.toJson()).toList();

      // Save the new list of meditations
      await _meditationBox.put("meditations", meditationListJson);

      // Show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Meditation added"),
          duration: Duration(seconds: 2),
        ),
      );
      print("Meditation added");
    } catch (e) {
      print("Service error: $e");
    }
  }

  //get all the meditations
  List<MeditationContent> getMeditations() {
    try {
      //get all the meditations
      final dynamic allMeditatios = _meditationBox.get("meditations");
      //convert the dynamic list to a list of MeditationContent
      // final List<MeditationContent> meditationList = allMeditatios
      //     .map((meditation) => MeditationContent.fromJson(meditation))
      //     .toList();
      print(allMeditatios);
      return allMeditatios;
    } catch (e) {
      print(e);
      return [];
    }
  }

  //delete a meditation
  Future<void> deleteMeditation(MeditationContent meditation) async {
    try {
      //get all the meditations
      final dynamic allMeditatios = _meditationBox.get("meditations");
      //convert the dynamic list to a list of MeditationContent
      final List<MeditationContent> meditationList = allMeditatios
          .map((meditation) => MeditationContent.fromJson(meditation))
          .toList();

      //delete the meditation
      meditationList.remove(meditation);
      //save the new meditation
      await _meditationBox.put("meditations", allMeditatios);
      print("Meditation deleted");
    } catch (e) {
      print(e);
    }
  }
}
