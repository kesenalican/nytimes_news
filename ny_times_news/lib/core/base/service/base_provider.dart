import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:ny_times_news/core/constants/api_constants.dart';

final httpClientProvider = FutureProvider<Dio>((ref) async {
  return Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
});
