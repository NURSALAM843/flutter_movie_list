import 'package:dio/dio.dart';
import 'package:flutter_movie/app/models/movie_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    MovieList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<List<MovieModel>> MovieList() async {
    var response = await Dio().get(
      "https://api.themoviedb.org/3/movie/now_playing?page=2&api_key=5399ae210273ce41bf1278263e59aafa",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    return MovieModel.fromJsonList(response.data['results']);
  }
}
