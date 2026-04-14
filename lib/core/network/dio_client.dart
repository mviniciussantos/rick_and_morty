import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class DioClient {
  static Dio create() {
    final dio = Dio();

    final cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.forceCache,
    );

    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));

    return dio;
  }
}
