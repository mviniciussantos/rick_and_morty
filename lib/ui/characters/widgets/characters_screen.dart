import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty/ui/characters/view_model/characters_view_model.dart';
import 'package:rick_and_morty/ui/characters/widgets/character_item_list.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({
    super.key,
    required this.viewModel,
    required this.charactersIds,
  });

  final CharactersViewModel viewModel;
  final List<String> charactersIds;

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.getCharacters(widget.charactersIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personagens deste episódio')),
      body: Selector<CharactersViewModel, List<Character>>(
        selector: (context, viewModel) => viewModel.characters,
        builder: (context, characters, child) {
          if (widget.viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (widget.viewModel.error != null) {
            return Center(
              child: Text(
                'Erro inesperado, por favor tente novamente mais tarde',
              ),
            );
          }
          return ListView.builder(
            itemCount: characters.length,
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final character = characters[index];
              return CharacterItemList(character: character);
            },
          );
        },
      ),
    );
  }
}
