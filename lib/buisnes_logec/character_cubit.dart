import 'package:bloc/bloc.dart';
import 'package:firsts_api/data/models/Character.dart';
import 'package:firsts_api/data/models/quites.dart';
import 'package:firsts_api/data/repestores/Characters_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {

 final CharactersRepository charactersRepository;
 List<Character>characters=[];

 CharacterCubit( this.charactersRepository) : super(CharacterInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
     this.characters =characters;
    });
    return characters;
  }

 void getQuotes(String charName) {
   charactersRepository.getCharacterQuotes(charName).then((quotes) {
     emit(QuotesLoaded(quotes));
   });
 }

}

