import 'package:firsts_api/conestanse/colors.dart';
import 'package:firsts_api/data/models/Character.dart';
import 'package:firsts_api/presentation/Screens/characters_details_screen.dart';
import 'package:flutter/material.dart';

import '../../conestanse/strings.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key,required  this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MycColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context,charactersDetailsScreen,arguments:character ),
        child: GridTile(
          child: Hero(
            tag: character.charId!,
            child: Container(
              color: MycColors.myGrey,
             child: character.image!.isNotEmpty
                 ? FadeInImage.assetNetwork(
                width: double.infinity,
                  height: double.infinity,
                  placeholder: 'images/loading.gif',
                  image: character.image!,
                fit: BoxFit.cover,
              ) : Image.asset("images/fav.jpg"),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text("${character.name}",style: TextStyle(
              height: 1.3,
              fontSize:16,
              color: MycColors.myWhite,
              fontWeight: FontWeight.bold,
            ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,

            ),
          ),
        ),
      ),
    );
  }
}
