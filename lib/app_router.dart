import 'package:firsts_api/buisnes_logec/character_cubit.dart';
import 'package:firsts_api/conestanse/strings.dart';
import 'package:firsts_api/data/models/Character.dart';
import 'package:firsts_api/data/repestores/Characters_repository.dart';
import 'package:firsts_api/data/wepserves/characters_web_service.dart';
import 'package:firsts_api/presentation/Screens/characters_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/Screens/CharactrersScreen.dart';
class AppRouter{

  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;

  AppRouter(){
    charactersRepository =CharactersRepository(CharactersWebServices());
    characterCubit =CharacterCubit(charactersRepository) ;
  }

  Route? generateRoute(RouteSettings settings ){
  switch(settings.name){
    case caractersScreen:
      return MaterialPageRoute(builder: (_) =>BlocProvider(
          create: (BuildContext context)=> characterCubit,
        child: CaractureScreens(),
      ),
      );

    case charactersDetailsScreen:
      final character=settings.arguments as Character;

      return MaterialPageRoute(
        builder: (_) => BlocProvider(
        create: (BuildContext context)=>
            CharacterCubit(charactersRepository),
          child: CharacterDetailsScreen(
            character: character,
          ),
        ),
      );

   }
  }
}