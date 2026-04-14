import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/data/repositories/character/character_repository.dart';
import 'package:rick_and_morty/data/repositories/character/character_repository_remote.dart';
import 'package:rick_and_morty/data/repositories/episode/character_repository_remote.dart';
import 'package:rick_and_morty/data/repositories/episode/episode_repository.dart';
import 'package:rick_and_morty/data/services/api/rick_and_morty_service.dart';
import 'package:rick_and_morty/domain/usecases/get_characters_usecase.dart';
import 'package:rick_and_morty/domain/usecases/get_episodies_usecase.dart';
import 'package:rick_and_morty/routing/router_config.dart' as routing;
import 'package:rick_and_morty/ui/characters/view_model/characters_view_model.dart';
import 'package:rick_and_morty/ui/episodes/view_model/episodes_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Dio()),
        Provider(create: (context) => RickAndMortyService(context.read<Dio>())),
        Provider<EpisodeRepository>(
          create: (context) =>
              EpisodeRepositoryRemote(context.read<RickAndMortyService>()),
        ),
        Provider<CharacterRepository>(
          create: (context) =>
              CharacterRepositoryRemote(context.read<RickAndMortyService>()),
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
