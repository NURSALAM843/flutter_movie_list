import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/movie_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
        centerTitle: false,
        actions: const [
          Icon(Icons.search),
          SizedBox(
            width: 20.0,
          ),
          Icon(Icons.more_vert),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: FutureBuilder<List<MovieModel>>(
          future: controller.MovieList(),
          builder: (context, snap) {
            print(snap);
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snap.data == 0 || snap.data == null) {
              return const Center(
                child: Text("Tidak Ada Data"),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: snap.data!.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                MovieModel movie = snap.data![index];

                return Card(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 170,
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Positioned(
                              top: 5.0,
                              right: 5.0,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "${movie.voteAverage}",
                                    style: TextStyle(
                                        color: Colors.red[500],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 5.0,
                              left: 10.0,
                              child: Row(
                                children: [
                                  Text(
                                    "${movie.originalLanguage}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          movie.originalTitle!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
