import 'package:fihirana/app/utils/AppTheme.dart';
import 'package:fihirana/app/widgets/MusicWidget.dart';
import 'package:fihirana/models/music_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: AppThemes.primary,
          title: const Text(
            'Fihirana',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: Scaffold.of(context).openDrawer,
              icon: const Icon(Icons.menu),
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Container(
                                  height: 5,
                                  width: 100,
                                  color: Colors.grey[400],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Aide",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: AppThemes.primary),
                                textAlign: TextAlign.center,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Text(
                                  "Vous pouvez rechercher par titre | par page | ou par clée",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 250,
                                height: 250,
                                child: Lottie.asset(
                                    'assets/animation/search_music.json'),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.live_help, color: Colors.white),
            )
          ],
          automaticallyImplyLeading: false,
        ),
        drawer: SafeArea(
          child: Drawer(
            backgroundColor: Colors.grey[300],
            child: Column(children: [
              //logo
              DrawerHeader(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10.0), // Choisir le rayon souhaité
                  child: Image.asset(
                    "assets/images/samuel_pro_2.jpeg",
                    fit: BoxFit
                        .cover, // Assure que l'image est correctement ajustée
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Divider(color: Colors.grey[400]),
              ),
              Column(
                children: [
                  const Text(
                    "Application Fihirana",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: const Text(
                      "Application pour les musiciens, où on peut voir la position des notes sur la portée musicale",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(8.0),
            width: Get.width,
            height: Get.height,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5.0),
                  child: TextField(
                    controller: controller.SearchEditingController,
                    onChanged: (str) => {controller.searchMusic()},
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: AppThemes.primary,
                      hintText: "Rechercher ...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: AppThemes.primary),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              Music music = controller.musicList[index];
                              return Column(
                                children: [
                                  MusicWidget(
                                      page: music.page ?? '',
                                      keyy: music.key ?? '',
                                      title: music.title ?? '')
                                ],
                              );
                            },
                            itemCount: controller.musicList.length,
                          ),
                  ),
                )
              ],
            )));
  }
}
