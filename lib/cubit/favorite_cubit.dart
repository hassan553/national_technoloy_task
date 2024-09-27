import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national_technoloy_task/cubit/favorite_state.dart';
import 'package:national_technoloy_task/model/question_model.dart';

import '../data/data_source.dart';
import '../widgets/show_snack_bar_widget.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  LocalDatabase localDatabase = LocalDatabase.instants;
  static FavoriteCubit get(context) => BlocProvider.of(context);

  addToFavorite(
      {required BuildContext context,
      required QuestionModel favoriteModel}) async {
    var result = await localDatabase.addToFavorite(favoriteModel);
    result.fold((l) {
      showSnackBarMessage(context: context, isSuccess: false, message: l);
      emit(AddFavoriteError());
    }, (r) {
      showSnackBarMessage(context: context, isSuccess: true, message: r);
      emit(AddFavoriteSuccess());
    });
  }

  List<QuestionModel> favoriteList = [];
  getAllFavorite() async {
    var result = localDatabase.getFavorite();
    result.fold((l) {
      emit(GetFavoriteError());
    }, (r) {
      favoriteList = r;
      emit(GetFavoriteSuccess());
    });
  }

  bool itemIsFavorite({required int id}) {
    return localDatabase.itemIsFavorite(id);
  }

  removeFromFavorite({required BuildContext context, required int id}) async {
    var result = await localDatabase.removeFromFavorite(id);
    favoriteList.removeWhere((element) => element.id == id);
    result.fold((l) {
      showSnackBarMessage(context: context, isSuccess: false, message: l);
      emit(RemoveFavoriteError());
    }, (r) {
      showSnackBarMessage(context: context, isSuccess: true, message: r);
      emit(RemoveFavoriteSuccess());
    });
  }
}
