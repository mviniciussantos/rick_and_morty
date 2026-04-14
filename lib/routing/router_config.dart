import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/routing/routes.dart';
import 'package:rick_and_morty/ui/characters/view_model/characters_view_model.dart';
import 'package:rick_and_morty/ui/characters/widgets/characters_screen.dart';
import 'package:rick_and_morty/ui/episodes/view_model/episodes_view_model.dart';
import 'package:rick_and_morty/ui/episodes/widgets/episodes_screen.dart';

GoRouter routerConfig = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) =>
          EpisodesScreen(viewModel: context.read<EpisodesViewModel>()),
    ),
    GoRoute(
      path: Routes.characaters,
      builder: (context, state) {
        final extra = state.extra as List<String>;
        final ids = extra.map((e) => e.split('/').last).toList();
        return CharactersScreen(
          viewModel: context.read<CharactersViewModel>(),
          charactersIds: ids,
        );
      },
    ),
  ],
);
