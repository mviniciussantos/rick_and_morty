import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/date_utils.dart';
import 'package:rick_and_morty/domain/models/episode.dart';

class EpisodeItemList extends StatelessWidget {
  const EpisodeItemList({
    super.key,
    required this.episode,
    required this.onTap,
  });

  final Episode episode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text('S${episode.episode} - ${episode.name}'),
        subtitle: Text('Lançamento: ${formatDate(episode.airDate)}'),
      ),
    );
  }
}
