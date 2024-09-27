import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../model/question_model.dart';

class LocalDatabase {
  LocalDatabase._();
  static LocalDatabase? _instants;
  static LocalDatabase get instants {
    _instants ??= LocalDatabase._();
    return _instants!;
  }

  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(QuestionModelAdapter());
    await Hive.openBox<QuestionModel>(AppConstants.favoriteBox);
  }

  final _favoriteBox = Hive.box<QuestionModel>(AppConstants.favoriteBox);

  Future<Either<String, String>> addToFavorite(
      QuestionModel favoriteModel) async {
    try {
      await _favoriteBox.put(favoriteModel.id, favoriteModel);
      return const Right('Success add to favorite');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Either<String, List<QuestionModel>> getFavorite() {
    try {
      final allData = _favoriteBox.values.toList();
      return Right(allData);
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, String>> removeFromFavorite(int id) async {
    try {
      await _favoriteBox.delete(id);
      return const Right('Success remove from favorite');
    } catch (error) {
      return Left(error.toString());
    }
  }

  bool itemIsFavorite(int id) {
    var result = _favoriteBox.get(id);
    return result == null ? false : true;
  }
}
