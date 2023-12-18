import 'package:fihirana/models/music_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';

class HomeController extends GetxController {
  RxList<Music> musicList = <Music>[].obs;
  TextEditingController SearchEditingController = TextEditingController();
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadMusicData();
  }

  void searchMusic() async {
    await loadMusicData();
    final searchText = SearchEditingController.text.toLowerCase();
    if (searchText.isEmpty) {
      // If the search text is empty, show all items
      return;
    } else {
      // If there's a search text, filter the list based on the entered text
      final filteredList = musicList.where((music) =>
          music.page?.toLowerCase().contains(searchText) == true ||
          music.title?.toLowerCase().contains(searchText) == true ||
          music.key?.toLowerCase().contains(searchText) == true);

      musicList.assignAll(filteredList.toList());
    }
  }

  Future<void> loadMusicData() async {
    isLoading.value = true;
    try {
      String jsonString =
          await rootBundle.loadString("assets/model/music.json");
      Map<String, dynamic> jsonData = json.decode(jsonString);

      if (jsonData.containsKey("data")) {
        List<dynamic> jsonList = jsonData["data"];

        // print("jsonList: $jsonList");

        musicList.assignAll(
          jsonList.map((json) => Music.fromJson(json)).toList(),
        );
      } else {
        print("Error: 'data' property not found in JSON");
      }
    } catch (e) {
      print("Error loading music data: $e");
    } finally {
      isLoading.value = false; // Marquer le chargement comme terminé
    }
  }
}
