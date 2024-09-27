import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national_technoloy_task/constants/constants.dart';
import 'package:national_technoloy_task/cubit/favorite_cubit.dart';
import 'package:national_technoloy_task/screens/favorite_screen.dart';

import '../cubit/favorite_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('National Technology Task'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const FavoriteScreen()));
        },
        child: const Icon(Icons.heart_broken_sharp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(AppConstants.questionsList[index].title)),
                      const SizedBox(width: 10),
                      BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, state) {
                          var cubit = FavoriteCubit.get(context);
                          return IconButton(
                              onPressed: () {
                                if (cubit.itemIsFavorite(
                                        id: AppConstants
                                            .questionsList[index].id) ==
                                    true) {
                                  cubit.removeFromFavorite(
                                      context: context,
                                      id: AppConstants.questionsList[index].id);
                                } else {
                                  cubit.addToFavorite(
                                      context: context,
                                      favoriteModel:
                                          AppConstants.questionsList[index]);
                                }
                              },
                              icon: Icon(
                                Icons.star,
                                color: cubit.itemIsFavorite(
                                        id: AppConstants
                                            .questionsList[index].id)
                                    ? Colors.green
                                    : Colors.grey,
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: AppConstants.questionsList.length),
      ),
    );
  }
}
