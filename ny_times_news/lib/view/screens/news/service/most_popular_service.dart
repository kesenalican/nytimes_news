import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ny_times_news/core/base/service/base_provider.dart';
import 'package:ny_times_news/core/constants/api_constants.dart';
import 'package:ny_times_news/view/screens/news/model/news_model.dart';

final getMostPopularNews = FutureProvider.autoDispose((ref) async {
  final dio = ref.watch(httpClientProvider);
  final result = await dio.value!.get(
    ApiConstants.apiKey,
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );
  if (result.statusCode == 200) {
    List<dynamic> results = result.data['results'];
    List<Result> myList = results.map((e) => Result.fromJson(e)).toList();
    return myList;
  } else {
    return [];
  }
});
