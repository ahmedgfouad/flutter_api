import 'package:firsts_api/data/models/quites.dart';
import 'package:firsts_api/data/wepserves/characters_web_service.dart';

import '../models/Character.dart';

class CharactersRepository{

final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>>getAllCharacters()async{
    final characters =await charactersWebServices.getAllCharacters();
    return characters.map((character)=>Character.fromJson(character)).toList();
  }


Future<List<Quote>>getCharacterQuotes(String charName)async{
  final quotes =await charactersWebServices.getAllCharacterQuotes(charName);
  return quotes.map((charQuotes)=>Quote.fromJson(charQuotes)).toList();
}

}