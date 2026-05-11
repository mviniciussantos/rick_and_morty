import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/core/hive_client.dart';
import 'package:rick_and_morty/core/network/dio_client.dart';
import 'package:rick_and_morty/data/datasources/character_local_data_source.dart';
import 'package:rick_and_morty/data/datasources/episode_local_data_source.dart';
import 'package:rick_and_morty/data/repositories/character/character_repository.dart';
import 'package:rick_and_morty/data/repositories/character/character_repository_offline.dart';
import 'package:rick_and_morty/data/repositories/episode/episode_repository_remote.dart';
import 'package:rick_and_morty/data/repositories/episode/episode_repository.dart';
import 'package:rick_and_morty/data/repositories/episode/episode_repository_offline.dart';
import 'package:rick_and_morty/data/services/api/rick_and_morty_service.dart';
import 'package:rick_and_morty/domain/usecases/get_characters_usecase.dart';
import 'package:rick_and_morty/domain/usecases/get_episodies_usecase.dart';
import 'package:rick_and_morty/routing/router_config.dart' as routing;
import 'package:rick_and_morty/ui/characters/view_model/characters_view_model.dart';
import 'package:rick_and_morty/ui/episodes/view_model/episodes_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveClient.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => DioClient.create()),
        Provider(create: (context) => RickAndMortyService(context.read<Dio>())),
        Provider<EpisodeRepository>(
          create: (context) => EpisodeRepositoryOffline(
            EpisodeLocalDataSourceImpl(),
            context.read<RickAndMortyService>(),
          ),
        ),
        Provider<CharacterRepository>(
          create: (context) => CharacterRepositoryOffline(
            context.read<RickAndMortyService>(),
            CharacterLocalDataSourceImpl(),
          ),
        ),
        Provider<GetEpisodesUseCase>(
          create: (context) =>
              GetEpisodesUseCaseImpl(context.read<EpisodeRepository>()),
        ),
        Provider<GetCharactersUseCase>(
          create: (context) =>
              GetCharactersUseCaseImpl(context.read<CharacterRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              EpisodesViewModel(context.read<GetEpisodesUseCase>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              CharactersViewModel(context.read<GetCharactersUseCase>()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: routing.routerConfig,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
