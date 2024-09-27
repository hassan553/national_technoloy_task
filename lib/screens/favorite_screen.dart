import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorite_cubit.dart';
import '../cubit/favorite_state.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    FavoriteCubit.get(context).getAllFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Favorite Questions'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            var cubit = FavoriteCubit.get(context);
            if (cubit.favoriteList.isEmpty) {
              return const Center(child: Text('No Favorite Questions'));
            } else {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(cubit.favoriteList[index].title)),
                            const SizedBox(width: 10),
                            IconButton(
                                onPressed: () {
                                  cubit.removeFromFavorite(
                                      context: context,
                                      id: cubit.favoriteList[index].id);
                                },
                                icon:
                                    const Icon(Icons.star, color: Colors.green))
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: cubit.favoriteList.length);
            }
          },
        ),
      ),
    );
  }
}
