part of 'character_cubit.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharactersLoaded extends CharacterState{
  late final List<Character> characters;

  CharactersLoaded(this.characters);
}

class QuotesLoaded extends CharacterState{
  late final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}