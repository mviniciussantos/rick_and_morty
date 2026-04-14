import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/domain/models/episode.dart';
import 'package:rick_and_morty/routing/routes.dart';
import 'package:rick_and_morty/ui/episodes/view_model/episodes_view_model.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/ui/episodes/widgets/episode_item_list.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key, required this.viewModel});

  final EpisodesViewModel viewModel;

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Defer to avoid "setState() called during build"
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.getEpisodes();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Trigger next page when within 200px of the bottom
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      widget.viewModel.getEpisodes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Episodes')),
      body: Selector<EpisodesViewModel, List<Episode>>(
        selector: (context, viewModel) => viewModel.episodes,
        builder: (context, episodes, child) {
          if (widget.viewModel.isLoading) {
            return Expanded(
              child: const Center(child: CircularProgressIndicator()),
            );
          } else if (widget.viewModel.error != null) {
            return Center(
              child: Text(
                'Erro inesperado, por favor tente novamente mais tarde',
              ),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: episodes.length + 1,
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) {
              if (index == episodes.length) {
                return Selector<EpisodesViewModel, bool>(
                  selector: (_, vm) => vm.hasNext,
                  builder: (_, hasNext, __) {
                    if (!hasNext) return const SizedBox.shrink();
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                );
              }
              final episode = episodes[index];
              return EpisodeItemList(
                episode: episode,
                onTap: () {
                  context.push(Routes.characaters, extra: episode.characters);
                },
              );
            },
          );
        },
      ),
    );
  }
}
