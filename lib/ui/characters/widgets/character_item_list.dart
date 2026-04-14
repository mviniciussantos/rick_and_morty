import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/domain/models/character.dart';

class CharacterItemList extends StatelessWidget {
  const CharacterItemList({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: CachedNetworkImage(
          imageUrl: character.image,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      title: Text(character.name),
      subtitle: Text(character.species),
      trailing: Text(character.status),
    );
  }
}
